class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :gender
      t.string :created_at
      t.string :updated_at

      t.timestamps
    end
  end
end
