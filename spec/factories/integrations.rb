# frozen_string_literal: true

# == Schema Information
#
# Table name: integrations
#
#  id               :bigint           not null, primary key
#  integration_type :integer          default("slack"), not null
#  name             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#  workspace_id     :bigint           not null
#
# Indexes
#
#  index_integrations_on_user_id       (user_id)
#  index_integrations_on_workspace_id  (workspace_id)
#
FactoryBot.define do
  factory :integration do
  end
end
