class RemovePhoneFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phone, :integer
  end
end
