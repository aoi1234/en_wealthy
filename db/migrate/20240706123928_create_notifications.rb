class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notifiable_type
      t.integer :notifiable_id
      t.boolean :read

      t.timestamps
    end
  end
end
