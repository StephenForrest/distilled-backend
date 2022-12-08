# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe UpdateSuccessCriteriaMutation, type: :graphql do
    let(:user) { create(:user_with_workspace) }
    let(:workspace) { user.workspaces.first }
    let(:plan) { create(:plan, user:, workspace:) }
    let(:goal) { create(:goal, owner_id: user.id, plan:) }
    let(:plan_id) { plan.uuid }
    let(:goal_id) { goal.to_param }
    let(:name) { 'name' }
    let(:description) { 'description' }
    let(:start_date) { DateTime.now.utc.to_s }
    let(:end_date) { DateTime.now.utc.to_s }
    let(:current_user) { user }
    let(:current_workspace) { workspace }
    let!(:success_criteria) { create(:success_criteria, :with_checklist_action, goal:) }
    let(:tracking_settings) do
      {
        checklist: [{
          id: 'id', item: 'test', dueDate: DateTime.now.utc.to_s, checked: false
        }]
      }
    end

    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($planUuid: String!,
            $goalId: String!,
            $successCriteriaId: String!
            $name: String!,
            $description: String!,
            $startDate: String!,
            $endDate: String!,
            $trackingSettings: ActionTrackingInput!
          ) {
            updateSuccessCriteria(
              planUuid: $planUuid,
              goalId: $goalId,
              name: $name,
              description: $description,
              startDate: $startDate,
              endDate: $endDate,
              successCriteriaId: $successCriteriaId,
              trackingSettings: $trackingSettings) {
                successCriteria {
                  id
                }
                errors
            }
          }
        GQL
      end

      subject do
        execute_graphql(
          mutation,
          { planUuid: plan_id, goalId: goal_id, successCriteriaId: success_criteria.to_param,
            name:, description:, startDate: start_date,
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

      context 'with correct auth' do
        it 'updates the settings' do
        end

        context 'when checklist validations fail' do
          let(:tracking_settings) do
            {
              checklist: [{
                id: 'id', item: 'test', dueDate: DateTime.now.utc.to_s, checked: false
              }, {
                id: 'id-no-item-name', item: '', dueDate: DateTime.now.utc.to_s, checked: false
              }, {
                id: 'id-invalid-due-date', item: 'arindam', dueDate: (DateTime.now + 12.days).utc.to_s, checked: false
              }]
            }
          end

          it 'does not create and returns an error' do
            result = subject
            tracking_settings = result['data']['updateSuccessCriteria']['errors']['trackingSettings']
            expect(tracking_settings['id-no-item-name']['item']).to eq('Give it a name')
            expect(tracking_settings['id-invalid-due-date']['dueDate'])
              .to eq("Due date cannot be later than the action's due date")
          end
        end
      end
    end
  end
end
