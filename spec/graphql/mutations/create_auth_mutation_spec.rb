# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateAuthMutation, type: :graphql do
    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($email: String!, $password: String!) {
            createAuth(email: $email, password: $password) {
              sessionId
            }
          }
        GQL
      end

      let!(:user) { FactoryBot.create(:user) }
      subject do
        execute_graphql(
          mutation,
          { email:, password: }
        )
      end

      context 'when correct credentials are correct' do
        let(:email) { 'john@example.com' }
        let(:password) { 'test' }

        it 'returns 200 and a session token' do
          expect(subject['data']['createAuth']['sessionId']).to eq(UserSession.last.session_id)
        end
      end

      context 'when correct credentials are incorrecct' do
        let(:email) { 'john@example.com' }
        let(:password) { 'test-incorrect' }

        it 'returns 200 and a session token' do
          expect(subject['errors'].first['message']).to eq('Invalid credentials')
        end
      end
    end
  end
end
