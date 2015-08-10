class AddSessionToUser < ActiveRecord::Migration
  def up
		remove_column :users, :user_id, :integer
  end
	
	def down
		add_column :users, :user_id, :integer
	end
end
