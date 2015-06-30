class CreateApiPosts < ActiveRecord::Migration
  def change
    create_table :api_posts do |t|
      t.string :title
      t.text :body
      t.boolean :published

      t.timestamps null: false
    end
  end
end
