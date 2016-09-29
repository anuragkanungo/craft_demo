class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.integer :follower_id, feed: true
      t.integer :followed_id, feed: true
      t.timestamps
    end
    add_index :connections, [:follower_id, :followed_id], unique: true
  end
end
