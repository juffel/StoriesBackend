class AddTextToStories < ActiveRecord::Migration
  def change
    add_column :stories, :text, :text, :after=>:place
  end
end
