class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :account_id, index: true, null: false
      t.integer :balance, null: false, default: 0

      t.timestamps
    end
  end
end
