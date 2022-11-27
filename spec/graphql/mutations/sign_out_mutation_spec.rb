# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe SignOutMutation, type: :graphql do
    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($sessionId: String!) {
            signOut(sessionId: $sessionId) {
              sessionId
            }
          }
        GQL
      end

      subject do
        execute_graphql(
          mutation,
          { sessionId: session_id }
        )
      end

      context 'when correct credentials are correct' do
        let!(:user_session) { FactoryBot.create(:user_session, user: FactoryBot.create(:user), expired: false) }
        let!(:session_id) { user_session.session_id }

        it 'returns 200 and a session token' do
          expect(subject['data']['signOut']['sessionId']).to eq(session_id)
          expect(user_session.reload.expired).to eq(true)
        end
      end
    end
  end
end
