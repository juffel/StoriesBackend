class AddTitleToStories < ActiveRecord::Migration
  def change
    add_column :stories, :title, :string, :after=>:token
  end
end
