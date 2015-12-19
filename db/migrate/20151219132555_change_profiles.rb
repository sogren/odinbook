class ChangeProfiles < ActiveRecord::Migration
  def change
  	change_table :profiles do |t|
  		t.integer :user_id
  		t.boolean :private
  		t.datetime :birthday
  		t.string :country
  		t.text :about
  		t.string :gender
  		t.string :profession
  		t.string :education
  	end
  end
end