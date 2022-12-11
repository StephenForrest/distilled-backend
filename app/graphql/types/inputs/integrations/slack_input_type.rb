# frozen_string_literal: true

#
#  id             :bigint           not null, primary key
#  scopes         :json             not null
#  team_name      :string           default(""), not null
#  token          :text             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#  team_id        :string           not null
#  workspace_id   :bigint           not null
#

module Types
  module Inputs
    module Integrations
      class SlackInputType < Types::BaseInputObject
        argument :id, String, required: false
        argument :scopes, [String], required: true
        argument :team_name, String, required: true
        argument :team_id, String, required: true
        argument :token, String, required: true
      end
    end
  end
end
