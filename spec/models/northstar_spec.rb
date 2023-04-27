# == Schema Information
#
# Table name: northstars
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Northstar, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:title) }
    end
end