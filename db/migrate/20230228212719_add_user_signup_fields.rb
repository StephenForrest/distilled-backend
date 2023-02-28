class AddUserSignupFields < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :position, :string

    User.all.each do |user|
      name_parts = user.name.split(' ', 2)
      user.update!(
        first_name: name_parts[0],
        last_name: name_parts[1]
      )
    end

    remove_column :users, :name
  end

  def down
    add_column :users, :name, :string

    User.all.each do |user|
      user.update!(
        name: "#{user.first_name} #{user.last_name}"
      )
    end

    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :position
  end
end