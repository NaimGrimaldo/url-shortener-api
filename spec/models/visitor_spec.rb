# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visitor, type: :model do
  include_examples 'a Paranoid model'
  include_examples 'has_many relations', [], []
  it 'has a valid factory' do
    expect(build(:visitor)).to be_valid
  end
end
