# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  include_examples 'a Paranoid model'
  include_examples 'has_many relations', [], []

  let(:user) { build(:user) }
  it { expect(user).to validate_presence_of :name }
  it { expect(user).to validate_presence_of :last_name }
  it { expect(user).to validate_presence_of :email }
  it { expect(user.password.present?).to eq(true) }

  it { expect(user).to validate_uniqueness_of :email }
end
