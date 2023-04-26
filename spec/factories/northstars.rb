# == Schema Information
#
# Table name: northstars
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :northstar do
    title { "MyString" }
  end
end
