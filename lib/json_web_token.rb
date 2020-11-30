# frozen_string_literal: true

# JWT token management
class JsonWebToken
  class << self
    def encode(payload, exp = 36.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
    end

    def decode(token)
      body = JWT.decode(token,
                        Rails.application.credentials.secret_key_base, 'HS256').first
      HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end
  end
end
