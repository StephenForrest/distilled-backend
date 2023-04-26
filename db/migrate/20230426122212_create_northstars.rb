class CreateNorthstars < ActiveRecord::Migration[7.0]
  def change
    create_table :northstars do |t|
      t.string :title

      t.timestamps
    end
  end
end
