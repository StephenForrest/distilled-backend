# == Schema Information
#
# Table name: stripe_customers
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  stripe_customer_id :string
#  workspace_id       :bigint           not null
#
# Indexes
#
#  index_stripe_customers_on_stripe_customer_id  (stripe_customer_id)
#  index_stripe_customers_on_workspace_id        (workspace_id)
#
# Foreign Keys
#
#  fk_rails_...  (workspace_id => workspaces.id)
#
class StripeCustomer < ApplicationRecord
  belongs_to :workspace
end
