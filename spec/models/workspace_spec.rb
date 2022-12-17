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
#  string                :string
#  title                 :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe Workspace, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
