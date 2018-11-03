class CreateBaseUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :base_urls do |t|
      t.string :url
      t.boolean :is_scrap, default: false

      t.timestamps
    end
  end
end
