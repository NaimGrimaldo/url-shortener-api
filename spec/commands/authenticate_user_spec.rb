# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create :user, password: 'password' }
  subject(:valid_auth) { described_class.new(user.email, 'password') }
  subject(:no_user_registred) { described_class.new('foo', 'bar') }
  subject(:invalid_auth) { described_class.new(user.email, 'Hello World') }

  describe '.call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        result = invalid_auth.call
        expect(result.errors[:user_authentication]).to eq ['Invalid credentials']
      end
    end

    context 'when the user isnt registred' do
      it 'raises authentication error' do
        result = no_user_registred.call
        expect(result.errors[:user_authentication]).to eq ['User not registred']
      end
    end
  end
end
