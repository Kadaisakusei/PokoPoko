class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.bigint :illustration_id, null: false
      t.bigint :tag_id, null: false

      t.timestamps
    end
  end
end
