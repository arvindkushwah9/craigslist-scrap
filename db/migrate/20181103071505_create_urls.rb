class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.integer :base_url_id
      t.string :url
      t.boolean :is_scrap, default: false

      t.timestamps
    end
  end
end
