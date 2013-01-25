class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,          null: false
      t.string :name,           null: false
      t.string :password_digest
      t.string :api_key

      t.timestamps
    end

    add_index :users, [:email, :api_key], :unique => true
  end
end
