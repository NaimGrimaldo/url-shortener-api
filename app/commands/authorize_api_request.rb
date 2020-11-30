# frozen_string_literal: true

# used to perform the  request authorization
class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
    @autorization = @headers['Authorization']
  end

  def call
    user_valid?
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id])
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return errors.add :token, 'Missing token' unless @autorization.present?

    return headers['Authorization'].split(' ').last if @autorization.present?

    nil
  end

  def user_valid?
    return unless decoded_auth_token

    return errors.add :token, 'Invalid token' unless user

    @user
  end
end
