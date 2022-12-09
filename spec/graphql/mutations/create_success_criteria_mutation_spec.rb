# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateSuccessCriteriaMutation, type: :graphql do
    let(:user) { create(:user_with_workspace) }
    let(:workspace) { user.workspaces.first }
    let(:plan) { create(:plan, user:, workspace:) }
    let(:goal) { create(:goal, owner_id: user.id, plan:, workspace_id: workspace.id) }
    let(:plan_id) { plan.uuid }
    let(:goal_id) { goal.to_param }
    let(:current_user) { user }
    let(:current_workspace) { workspace }
    let(:name) { 'name' }
    let(:description) { 'description' }
    let(:start_date) { DateTime.now.utc.to_s }
    let(:end_date) { DateTime.now.utc.to_s }
    let(:success_criteria_type) { 'action' }
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
          mutation($goalId: String!, $successCriteriaType: String!, $name: String!, $description: String!, $startDate: String!, $endDate: String!, $trackingSettings: ActionTrackingInput!) {
            createSuccessCriteria(successCriteriaType: $successCriteriaType, goalId: $goalId, name: $name, description: $description, startDate: $startDate, endDate: $endDate, trackingSettings: $trackingSettings) {
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
          { planUuid: plan_id, successCriteriaType: success_criteria_type, goalId: goal_id, name:, description:, startDate: start_date,
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

      describe 'validation tests' do
        context 'when name is empty' do
          let(:name) { '' }

          it 'does not create and returns an error' do
            result = nil
            expect { result = subject }.to change { Action.all.size }
              .by(0)
              .and change { SuccessCriteria.all.size }.by(0)
              .and change { Checklist.all.size }.by(0)
            expect(result['data']['createSuccessCriteria']['errors']['name']).to eq('Please add a name')
          end
        end

        context 'when end_date is less than start_date' do
          let(:end_date) { (DateTime.new - 7.days).utc.to_s }
          let(:start_date) { DateTime.new.utc.to_s }

          it 'does not create and returns an error' do
            result = nil
            expect { result = subject }.to change { Action.all.size }
              .by(0)
              .and change { SuccessCriteria.all.size }.by(0)
              .and change { Checklist.all.size }.by(0)
            expect(result['data']['createSuccessCriteria']['errors']['endDate']).to eq('End date cannot be later than start date')
          end
        end

        context 'when end_date is less than goal_date' do
          let(:goal) { create(:goal, owner_id: user.id, plan:, expires_on: (DateTime.new - 10.days).utc.to_s, workspace_id: workspace.id) }
          let(:end_date) { (DateTime.new - 7.days).utc.to_s }
          let(:start_date) { (DateTime.new - 10.days).utc.to_s }

          it 'does not create and returns an error' do
            result = nil
            expect { result = subject }.to change { Action.all.size }
              .by(0)
              .and change { SuccessCriteria.all.size }.by(0)
              .and change { Checklist.all.size }.by(0)
            expect(result['data']['createSuccessCriteria']['errors']['endDate']).to eq('End date cannot be later than goal end date')
          end
        end

        context 'when checklist validations fail' do
          let(:tracking_settings) do
            {
              checklist: [{
                id: 'id', item: 'test', dueDate: DateTime.now.utc.to_s, checked: false
              }, {
                id: 'id-no-item-name', item: '', dueDate: DateTime.now.utc.to_s, checked: false
              }, {
                id: 'id-invalid-due-date', item: 'arindam', dueDate: (DateTime.now + 10.days).utc.to_s, checked: false
              }]
            }
          end

          it 'does not create and returns an error' do
            result = nil
            expect { result = subject }.to change { Action.all.size }
              .by(0)
              .and change { SuccessCriteria.all.size }.by(0)
              .and change { Checklist.all.size }.by(0)
            tracking_settings = result['data']['createSuccessCriteria']['errors']['trackingSettings']
            expect(tracking_settings['id-no-item-name']['item']).to eq('Give it a name')
            expect(tracking_settings['id-invalid-due-date']['dueDate'])
              .to eq("Due date cannot be later than the action's due date")
          end
        end
      end
    end
  end
end
