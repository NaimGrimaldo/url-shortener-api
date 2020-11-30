# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :links, inverse_of: :user

  validates :name, :last_name, :email, :password, presence: true
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: { case_sensitive: true },
                       length: { minimum: 6 }
end
