class CreateSnaps < ActiveRecord::Migration
  def up
		create_table :snaps do |t|
			t.string :to
			t.string :caption
			t.string :timer
			t.string :time
			t.string :format
			t.string :link
			t.string :read
		end
  end
	
	def down
		drop_table :snaps
	end
end
