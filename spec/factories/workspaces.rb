# frozen_string_literal: true

# == Schema Information
#
# Table name: workspaces
#
#  id                    :bigint           not null, primary key
#  auto_created          :boolean          default(TRUE), not null
#  auto_join_from_domain :boolean          default(FALSE), not null
#  boolean               :boolean          default(FALSE), not null
#  domain                :string
#  onboarding_steps      :jsonb            not null
#  string                :string
#  stripe_product        :string
#  title                 :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
FactoryBot.define do
  factory :workspace do
    title { 'Sample Workspace' }
    domain { 'test.com' }
  end
end
