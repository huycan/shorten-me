class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :full_url, null: false
      t.string :short_url

      t.timestamps null: false
    end
    add_index :urls, :short_url
  end
end
