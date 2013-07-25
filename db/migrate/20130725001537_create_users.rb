class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.date :born_on
      t.string :zip_code
      t.text :bio
      t.boolean :is_minor, default: true
      t.string :salt
      t.string :fish
      t.string :code
      t.timestamp :expires_at
      t.boolean :is_superuser, default: false

      t.timestamps
    end
  end
end
