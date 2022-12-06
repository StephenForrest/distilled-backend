class FixSpellingOfSuccessCriteria < ActiveRecord::Migration[7.0]
  def change
    rename_table :success_criterias, :success_criterias
  end
end
