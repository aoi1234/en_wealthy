class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :title
      t.text :body
      t.text :industry
      t.string :category

      t.timestamps
    end
  end
end
