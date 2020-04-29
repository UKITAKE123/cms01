class AddEmailIndexToAdministrators < ActiveRecord::Migration[6.0]
  def change
    add_index :administrators, :email, unique: true
  end
end
