class AddProfileToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nick_name, :string
    add_column :users, :gender, :string
    add_column :users, :dob, :date
    add_column :users, :code, :string
    add_column :users, :number, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :address, :string
    add_column :users, :country, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :image_url, :string
    add_column :users, :approve, :boolean, :default => true
  end
end
