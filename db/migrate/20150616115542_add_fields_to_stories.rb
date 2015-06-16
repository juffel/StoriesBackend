class AddFieldsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :place, :string, :after=>:token
    add_column :stories, :narrator, :string, :after=>:token
  end
end
