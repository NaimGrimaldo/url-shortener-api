# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  include_examples 'a Paranoid model'
  include_examples 'has_many relations', [], []

  let(:link) { create(:link) }
  it 'has a valid factory' do
    expect(build(:link)).to be_valid
  end

  it { expect(link).to validate_presence_of :original_url }
end
