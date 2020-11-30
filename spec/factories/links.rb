# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    original_url { Faker::Internet.url }
    association :user
    expires_at { nil }
    unique_key { Faker::Name.first_name }
  end
end
