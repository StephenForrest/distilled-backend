class AddWorkspaceToModels < ActiveRecord::Migration[7.0]
  def change
    add_reference :goals, :workspace, null: false
    add_reference :success_criterias, :workspace, null: false
    add_reference :actions, :workspace, null: false
    add_reference :measurements, :workspace, null: false
    add_reference :checklists, :workspace, null: false
  end
end
