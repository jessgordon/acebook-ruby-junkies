class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.references :user, null: false, foreign_key: true
      t.string :friend_user

      t.timestamps
    end
  end
end
