# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateActionMutation, type: :graphql do
    let(:user) { create(:user_with_workspace) }
    let(:workspace) { user.workspaces.first }
    let(:plan) { create(:plan, user:, workspace:) }
    let(:goal) { create(:goal, owner_id: user.id, plan:) }
    let(:plan_id) { plan.uuid }
    let(:goal_id) { goal.to_param }
    let(:current_user) { user }
    let(:current_workspace) { workspace }
    let(:name) { 'name' }
    let(:description) { 'description' }
    let(:start_date) { DateTime.now.utc.to_s }
    let(:end_date) { DateTime.now.utc.to_s }
    let(:tracking_settings) do
      {
        checklist: [{
          id: 'id', item: 'test', dueDate: DateTime.now.utc.to_s
        }]
      }
    end

    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($planUuid: String!, $goalId: String!, $name: String!, $description: String!, $startDate: String!, $endDate: String!, $trackingSettings: ActionTrackingInput!) {
            createAction(planUuid: $planUuid, goalId: $goalId, name: $name, description: $description, startDate: $startDate, endDate: $endDate, trackingSettings: $trackingSettings) {
              action {
                id
              }
            }
          }
        GQL
      end

      subject do
        execute_graphql(
          mutation,
          { planUuid: plan_id, goalId: goal_id, name:, description:, startDate: start_date,
            endDate: end_date, trackingSettings: tracking_settings },
          {
            current_user:,
            current_workspace:
          }
        )
      end

      context 'when invalid auth' do
        let(:current_user) { nil }
        let(:current_workspace) { nil }

        it 'throws error' do
          expect(subject['errors'].first['message']).to eq('Authentication expired')
        end
      end

      context 'with valid user and workspace' do
        it 'creates an action, success criteria and checklist' do
          expect { subject }.to change { Action.all.size }
            .by(1)
            .and change { SuccessCriteria.all.size }.by(1)
            .and change { Checklist.all.size }.by(1)
        end
      end
    end
  end
end
