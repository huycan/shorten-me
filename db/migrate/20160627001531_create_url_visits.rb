class CreateUrlVisits < ActiveRecord::Migration
  def change
    create_table :url_visits do |t|
      t.references :url, index: true, foreign_key: true, null: false
      t.text :browser, index: true, null: false

      t.timestamps null: false
    end
  end
end
