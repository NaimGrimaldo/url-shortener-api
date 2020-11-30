# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create :user, password: '123123123' }
  let(:another_user) { create :user, password: '0000000' }
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  let(:user_token) { token_generator(user.id) }
  subject(:missing_token_request) { described_class.new({}) }
  subject(:invalid_request) do
    described_class.new({ 'Authorization' => 'wknfjklsnsnsdlnsdlknsdlknsd' })
  end
  subject(:valid_request) { described_class.new(header) }

  describe '.call' do
    context 'when valid request' do
      it 'returns user object' do
        result = valid_request.call
        expect(result.to_s).to match(/AuthorizeApiRequest/)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'returns missing token message' do
          result = missing_token_request.call
          expect(result.errors[:token]).to eq ['Missing token']
        end
      end

      context 'when invalid token' do
        it 'returns invalid token message' do
          result = invalid_request.call
          expect(result.errors[:token]).to eq nil
        end
      end
    end
  end
end
