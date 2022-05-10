class ChangeIntegerLimitInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :mobile, :integer, limit: 8 
  end
end
