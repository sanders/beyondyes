class User < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :legal_name, :string, :null => false
      t.column :name_key,   :string, :null => false
      t.column :password,   :string, :null => false
      t.column :created_at, :datetime

      t.column :email,      :string, :null => false
      t.column :email_key,  :string, :null => false
      t.column :email_verified_at, :datetime

      t.column :last_action_at, :datetime

      t.column :city, :string
      t.column :region, :string
      t.column :postal_code, :string
      t.column :country, :string
      t.column :address_verified_at, :datetime

      t.column :phone, :string

      t.column :voter_registration_id, :string

      t.column :birthdate, :date
      t.column :sex, :string
      t.column :sexual_orientation, :string
      t.column :religious_affiliations, :string
      t.column :race, :string
      t.column :height_inches, :integer
      t.column :weight_lbs, :integer
      t.column :marital_status, :string
    end
    add_index :users, :name_key
    add_index :users, :legal_name
    add_index :users, :password
    add_index :users, :created_at
    add_index :users, :email_key
    add_index :users, :email_verified_at
    add_index :users, :last_action_at
  end

  def self.down
    drop_table :users
  end
end
