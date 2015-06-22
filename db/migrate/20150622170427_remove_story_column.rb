class RemoveStoryColumn < ActiveRecord::Migration
  def change
    remove_column :stories, :audio
  end
end
