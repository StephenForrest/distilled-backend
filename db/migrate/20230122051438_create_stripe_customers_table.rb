class CreateStripeCustomersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_customers do |t|
      t.references :workspace, null: false, foreign_key: true, index: true
      t.string :stripe_customer_id
      t.timestamps
    end
    add_index :stripe_customers, :stripe_customer_id, unique: false
  end
end
