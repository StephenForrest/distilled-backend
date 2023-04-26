# == Schema Information
#
# Table name: northstars
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Northstar < ApplicationRecord
    # Define validations
    validates :title, presence: true
end
