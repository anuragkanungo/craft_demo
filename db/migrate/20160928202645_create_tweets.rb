class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.text :message, null: false
      t.numeric :user_id, null: false

      t.timestamps
      t.foreign_key :users, column: :user_id, index: true
    end
  end
end
