class CreateShortLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :short_links do |t|
      t.string :original_url
      t.string :shortner_path
      t.string :title
      t.integer :page_views, default: 0
      t.timestamps
    end
  end
end
