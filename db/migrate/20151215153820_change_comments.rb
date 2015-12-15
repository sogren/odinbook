class ChangeComments < ActiveRecord::Migration
  def change
  	change_table(:comments) do |t|
  		t.remove :commentable_id, :commentable_type
  		t.references :post
  	end
  end
end
