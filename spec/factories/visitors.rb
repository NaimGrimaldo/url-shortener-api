# frozen_string_literal: true

FactoryBot.define do
  factory :visitor do
    association :link
    ip { Faker::Internet.public_ip_v4_address }
    visitor_kind { 0 }
    visits { 1 }
  end
end
