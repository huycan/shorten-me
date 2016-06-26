class AddIndexToUrls < ActiveRecord::Migration
  def change
    add_index :urls, :full_url
  end
end
