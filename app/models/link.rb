# frozen_string_literal: true

# link model
class Link < ApplicationRecord
  include Rails.application.routes.url_helpers

  CHARSET = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  RGX_URL_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)
  belongs_to :user, inverse_of: :links
  has_many :visitors, inverse_of: :link

  validates :original_url, :unique_key, presence: true
  validate :url_valid?
  before_validation :generate_unique_key, unless: :unique_key?

  scope :unexpired, -> { where("expires_at IS NULL OR expires_at >= DATE('#{Time.zone.now}')") }

  def self.clean_url(url)
    url = url.to_s.strip
    return "/#{url}" if url !~ RGX_URL_PROTOCOL && url[0] != '/'

    URI.parse(url).normalize.to_s
  end

  def short_url(url_options: {})
    options = {
      controller: :"/links",
      action: :visit, id: unique_key,
      only_path: false
    }.merge(url_options)

    url_for(options)
  end

  def visit!(agent, request)
    increment_visits_count
    visitor = visitors.where(ip: request.ip).first_or_create
    visitor.register(agent)
  end

  private

  def generate_unique_key
    self.unique_key = (0...5).map { CHARSET[rand(CHARSET.size)] }.join
  end

  def url_valid?
    uri = Link.clean_url(original_url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue StandardError
    errors.add(:original_url, 'Invalid url')
  end

  def increment_visits_count
    self.class.increment_counter(:visits, id)
  end
end
