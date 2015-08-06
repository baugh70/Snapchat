class ModifySnaps < ActiveRecord::Migration
  def up
		add_column :snaps, :user_id, :integer
# 		add_column :snaps, :to_id, :integer
# 		remove_column :snaps, :to_id, :string
  end
	
	def down
		remove_column :snaps, :user_id, :integer
		# 		remove_column :snaps, :to_id, :integer
# 		add_column :snaps, :to, :string
	end
end
