# frozen_string_literal: true

# used to perform the authentication
class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
    user
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user_valid?
  end

  private

  attr_accessor :email, :password

  def user
    @user ||= User.find_by_email(email)
  end

  def user_valid?
    return error_response('User not registred') unless @user

    return error_response('Invalid credentials') unless @user.authenticate(password)

    true
  end

  def error_response(message)
    errors.add :user_authentication, message
  end
end
