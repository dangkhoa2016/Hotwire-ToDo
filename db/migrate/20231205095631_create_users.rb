class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :time_zone, null: false, default: 'UTC'
      t.string :locale, null: false, default: 'en'
      t.boolean :verified, null: false, default: false

      t.timestamps
    end
  end
end
