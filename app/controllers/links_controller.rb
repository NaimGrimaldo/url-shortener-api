# frozen_string_literal: true

class LinksController < ApplicationController
  include BasicCrudMethods
  skip_before_action :authenticate_request!, only: :visit

  def show
    set_object
    render json: @object, with_visitors: true, url_options: url_options
  rescue ActiveRecord::RecordNotFound
    render_error('Link not found', :not_found)
  end

  def create
    @object = model.new(object_params)
    @object.user = User.find(params[:user_id])
    if @object.save
      render json: @object, status: :created, url_options: url_options
    else
      render_error(@object.errors.full_messages.to_sentence,
                   :unprocessable_entity)
    end
  end

  def visit
    @link = Link.find_by(unique_key: params[:id])
    return render_error('Not found', :not_found) if @link.nil?

    return render_error('Expired', :unprocessable_entity) if url_expired?

    @link.visit!(user_agent, request)
    redirect_to @link.original_url
  end

  private

  def model
    @model ||= Link
  end

  def scope
    model.all.order(:created_at)
  end

  def object_params
    params.require(:link).permit(
      :original_url, :user_id, :expiration_date, :id, :unique_key, :expires_at
    )
  end

  def url_expired?
    @link.expires_at.present? && @link.expires_at < Time.zone.now
  end

  def url_options
    {
      url_options: {
        host: request.host,
        port: request.port
      }
    }
  end

  def user_agent
    @user_agent ||= Agent.new request.user_agent
  end
end
