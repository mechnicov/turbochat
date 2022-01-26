class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :message, null: false, foreign_key: true

      t.timestamps
    end

    change_table :messages do |t|
      t.integer :likes_count, null: false, default: 0
    end
  end
end
