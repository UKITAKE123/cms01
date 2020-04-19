class AddEmailIndexToStaffMembers < ActiveRecord::Migration[6.0]
  def change
    add_index :staff_members, :email, unique: true
  end
end
