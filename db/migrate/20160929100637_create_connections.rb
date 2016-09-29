class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.integer :follower_id, index: true
      t.integer :followed_id, index: true
      t.timestamps
    end
    add_index :connections, [:follower_id, :followed_id], unique: true
  end
end
