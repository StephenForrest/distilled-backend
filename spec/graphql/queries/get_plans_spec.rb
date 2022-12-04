# frozen_string_literal: true

require 'rails_helper'

module Queries
  RSpec.describe 'GetPlans', type: :graphql do
    let(:uuid) { nil }
    describe '.resolve' do
      let(:query) do
        <<~GQL
          query getPlans {
             getPlans {
               id
               name
             }
           }
        GQL
      end

      subject do
        execute_graphql(
          query,
          { uuid: },
          {
            current_user: user,
            current_workspace: workspace
          }
        )
      end

      context 'without a valid current user' do
        let(:user) { nil }
        let(:workspace) { nil }
        let(:uuid) { '123-123' }

        it 'returns auth error' do
          expect(subject['errors'].first['message']).to eq('Authentication expired')
        end
      end

      context 'with a valid user' do
        let(:user) { create(:user_with_workspace) }
        let(:workspace) { user.workspaces.first }
        let!(:plan) { create(:plan, user:, workspace:) }
        let(:uuid) { plan.uuid }

        it 'returns an error of plans' do
          expect(subject['data']['getPlans'].size).to eq(1)
        end
      end
    end
  end
end
