class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :display_name
      t.string :email, unique: true
      t.string :username, unique: true
      t.references :company, foreign_key: true
      t.timestamps
    end
  end
end
