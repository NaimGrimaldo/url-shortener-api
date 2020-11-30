# frozen_string_literal: true

FactoryBot.define do
  factory :visitor_agent do
    agent { Faker::Internet.user_agent(vendor: :chrome) }
    os { Faker::Computer.os }
    association :visitor
    visits { 1 }
    visited_at { '2020-11-30 06:30:05' }
  end
end
