class CreateOrganizationAndUserTables < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :country, null: false
      t.string :phone, null: false
      t.string :domain_name, null: false
      t.string :website_link, null: false
      t.string :logo
      t.text :description
      t.string :founded_year, null: false
      t.string :sport, null: false
      t.integer :status, default: 0
      t.timestamps
    end

    create_table :users do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.integer :role, null: false, default: 0
      t.boolean :active, default: true
      t.string :password_digest
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.string :authentication_token
      t.datetime :authentication_token_created_at
      t.datetime :authentication_token_expires_at
      t.string :invitation_token
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.string :profile_photo_url
      t.boolean :admin, default: false

      t.timestamps
    end

    add_index :organizations, :name, unique: true
    add_index :organizations, :domain_name, unique: true
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token, unique: true
    add_index :users, :authentication_token, unique: true
    add_index :users, :invitation_token, unique: true
  end
end
