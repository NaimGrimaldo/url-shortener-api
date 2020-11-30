# frozen_string_literal: true

# manage common app requests
class ApplicationController < ActionController::API
  before_action :authenticate_request!

  private

  def authenticate_request!
    current_user
    return unauthorized unless @current_user
  end

  def current_user
    @current_user ||= AuthorizeApiRequest.call(request.headers).result
  end

  def unauthorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
