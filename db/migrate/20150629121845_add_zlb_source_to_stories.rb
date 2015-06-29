class AddZlbSourceToStories < ActiveRecord::Migration
  def change
    add_column :stories, :zlb_id, :string, :after=>:text
    add_column :stories, :zlb_link, :string, :after=>:zlb_id
  end
end
