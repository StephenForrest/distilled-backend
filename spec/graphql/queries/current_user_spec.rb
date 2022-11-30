# frozen_string_literal: true

require 'rails_helper'

module Queries
  RSpec.describe 'CurrentUser', type: :graphql do
    describe '.resolve' do
      let(:query) do
        <<~GQL
          query currentUser {
             currentUser {
               id
               email
               name
             }
           }
        GQL
      end

      subject do
        execute_graphql(
          query,
          {},
          {
            current_user: user,
            current_workspace: workspace
          }
        )
      end

      context 'with valid current_user' do
        let(:user) { FactoryBot.create(:user_with_workspace) }
        let(:workspace) { user.workspaces.first }

        it 'returns current user' do
          result = subject['data']['currentUser']
          expect(result['id']).to eq(user.to_param)
          expect(result['name']).to eq(user.name)
          expect(result['email']).to eq(user.email)
        end
      end

      context 'without  valid auth' do
        let(:user) { nil }
        let(:workspace) { nil }

        it 'returns auth error' do
          expect(subject['errors'].first['message']).to eq('Authentication expired')
        end
      end
    end
  end
end
