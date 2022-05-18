class AddAdmin < ActiveRecord::Migration[6.1]
  def change
    User.find_by(email: 'leshasmp1989@mail.ru').update(admin: true)
  end
end
