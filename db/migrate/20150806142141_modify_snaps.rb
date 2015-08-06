class ModifySnaps < ActiveRecord::Migration
  def up
		add_column :snaps, :from_id, :integer
		add_column :snaps, :to_id, :integer
		remove_column :snaps, :to, :string
  end
	
	def down
		remove_column :snaps, :from_id, :integer
		remove_column :snaps, :to_id, :integer
		add_column :snaps, :to, :string
	end
end
