class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      t.text :comment
      t.integer :customer_id
      t.integer :illustration_id

      t.timestamps
    end
  end
end
