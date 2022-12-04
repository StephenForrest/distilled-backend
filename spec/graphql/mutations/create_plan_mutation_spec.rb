# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreatePlanMutation, type: :graphql do
    describe '.resolve' do
      let(:mutation) do
        <<~GQL
          mutation($name: String!) {
            createPlan(name: $name) {
              plan {
                id,
                name
              }
            }
          }
        GQL
      end

      subject do
        execute_graphql(
          mutation,
          { name: },
          {
            current_user: user,
            current_workspace: workspace
          }
        )
      end

      context 'when invalid auth' do
        let(:user) { nil }
        let(:workspace) { nil }
        let(:name) { 'John' }

        it 'throws error' do
          expect(subject['errors'].first['message']).to eq('Authentication expired')
        end
      end

      context 'with valid user and workspace' do
        let(:user) { create(:user_with_workspace) }
        let(:workspace) { user.workspaces.first }
        let(:name) { 'Test plan' }

        it 'creates a plan' do
          expect(subject['data']['createPlan']['plan']['id']).to eq(Plan.last.uuid)
        end
      end
    end
  end
end
