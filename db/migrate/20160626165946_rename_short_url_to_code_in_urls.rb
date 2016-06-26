class RenameShortUrlToCodeInUrls < ActiveRecord::Migration
  def change
    rename_column :urls, :short_url, :code
  end
end
