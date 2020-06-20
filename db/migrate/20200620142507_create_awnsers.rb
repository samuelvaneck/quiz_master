class CreateAwnsers < ActiveRecord::Migration[6.0]
  def change
    create_table :awnsers do |t|
      t.string :content
      t.integer :score
      t.references :question

      t.timestamps
    end
  end
end
