class AddTokenToStories < ActiveRecord::Migration
  def change
    add_column :stories, :token, :string, :after=>:audio
  end
end
