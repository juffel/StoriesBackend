class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.binary :audio, limit: 100.megabyte

      t.timestamps
    end
  end
end
