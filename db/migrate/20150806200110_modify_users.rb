class ModifyUsers < ActiveRecord::Migration
  def up
		add_column :users, :user_id, :integer
# 		add_column :snaps, :to_id, :integer
# 		remove_column :snaps, :to_id, :string
  end
	
	def down
		remove_column :users, :user_id, :integer
		# 		remove_column :snaps, :to_id, :integer
# 		add_column :snaps, :to, :string
	end
end
