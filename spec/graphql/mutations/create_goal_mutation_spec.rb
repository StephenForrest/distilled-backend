# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateGoalMutation, type: :graphql do
    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($title: String!, $planId: String!) {
            createGoal(title: $title, planId: $planId) {
              goal {
                id,
                title
              }
            }
          }
        GQL
      end

      subject do
        execute_graphql(
          mutation,
          { planId: plan_id, title: },
          {
            current_user: user,
            current_workspace: workspace
          }
        )
      end

      context 'when invalid auth' do
        let(:user) { nil }
        let(:workspace) { nil }
        let(:title) { 'Goal' }
        let(:plan_id) { create(:plan).to_param }

        it 'throws error' do
          expect(subject['errors'].first['message']).to eq('Authentication expired')
        end
      end

      context 'with valid user and workspace' do
        let(:user) { create(:user_with_workspace) }
        let(:workspace) { user.workspaces.first }
        let(:title) { 'Test goal' }
        let(:plan) { create(:plan, workspace:, user:) }
        let(:plan_id) { plan.to_param }

        it 'creates an goal' do
          expect(subject['data']['createGoal']['goal']['id']).to eq(Goal.last.to_param)
        end
      end
    end
  end
end
