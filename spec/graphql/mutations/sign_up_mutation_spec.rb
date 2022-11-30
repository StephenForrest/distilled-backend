# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe SignUpMutation, type: :graphql do
    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($email: String!, $password: String!, $name: String!) {
            signUp(email: $email, password: $password, name: $name) {
              sessionId
            }
          }
        GQL
      end

      subject do
        execute_graphql(
          mutation,
          { email:, password:, name: }
        )
      end

      context 'when new user is created' do
        let(:email) { 'hello@hello.com' }
        let(:password) { 'password' }
        let(:name) { 'John' }

        it 'returns 200 and a session token' do
          expect(subject['data']['signUp']['sessionId']).to eq(UserSession.last.session_id)
          expect(UserSession.last.user.email).to eq('hello@hello.com')
        end

        it 'creates a new workspace' do
          expect { subject }.to change { Workspace.all.count }.by(1)
        end
      end

      context 'when user already exists' do
        let(:email) { FactoryBot.create(:user).email }
        let(:password) { 'password' }
        let(:name) { 'John' }

        it 'returns 200 and a session token' do
          expect(subject['errors'].first['message']).to eq('User already exists')
        end
      end
    end
  end
end
