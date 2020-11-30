# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request!

  def authenticate
    authentication = AuthenticateUser.call(params[:email], params[:password])

    if authentication.success?
      render json: { auth_token: authentication.result }
    else
      render json: { error: authentication.errors }, status: :unauthorized
    end
  end
end
