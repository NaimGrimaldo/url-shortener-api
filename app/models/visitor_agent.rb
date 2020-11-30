# frozen_string_literal: true

class VisitorAgent < ApplicationRecord
  belongs_to :visitor, inverse_of: :visitor_agents
end
