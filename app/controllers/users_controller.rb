# frozen_string_literal: true

class UsersController < ApplicationController
  include BasicCrudMethods
  skip_before_action :authenticate_request!, only: :create
  private

  def model
    @model ||= User
  end

  def scope
    model.all.order(:created_at)
  end

  def object_params
    params.require(:user).permit(
      :name, :password, :last_name, :email, :id
    )
  end
end
