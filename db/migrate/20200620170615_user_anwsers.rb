class UserAnwsers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_awnsers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :awnser, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
