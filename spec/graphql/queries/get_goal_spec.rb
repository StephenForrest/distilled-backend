# frozen_string_literal: true

require 'rails_helper'

module Queries
  RSpec.describe 'GetGoal', type: :graphql do
    describe '.resolve' do
      let(:query) do
        <<~GQL
          query getGoal($id: String!) {
             getGoal(id: $id) {
               id
               title
               actionsCount
               measurementsCount
             }
           }
        GQL
      end

      subject do
        execute_graphql(
          query,
          { id: },
          {
            current_user: user,
            current_workspace: workspace
          }
        )
      end

      context 'without a valid current user' do
        let(:user) { nil }
        let(:workspace) { nil }
        let(:id) { '123-123' }

        it 'returns auth error' do
          expect(subject['errors'].first['message']).to eq('Authentication expired')
        end
      end

      context 'with a valid user' do
        let(:user) { create(:user_with_workspace) }
        let(:workspace) { user.workspaces.first }
        let(:plan) { create(:plan, user:, workspace:) }
        let(:goal) { create(:goal, owner_id: user.id, plan:) }
        let(:id) { goal.to_param }

        it 'returns a goal' do
          expect(subject['data']['getGoal']['id']).to eq(goal.to_param)
        end
      end
    end
  end
end
