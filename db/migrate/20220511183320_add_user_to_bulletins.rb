class AddUserToBulletins < ActiveRecord::Migration[6.1]
  def change
    add_reference :bulletins, :user, null: false, foreign_key: true, index: true
  end
end
