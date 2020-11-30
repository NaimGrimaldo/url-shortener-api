# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisitorAgent, type: :model do
  include_examples 'a Paranoid model'
  include_examples 'has_many relations', [], []

  it 'has a valid factory' do
    expect(build(:visitor_agent)).to be_valid
  end
end
