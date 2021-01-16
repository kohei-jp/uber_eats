class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.integer :restaurant_id, null: false, comment: '所属するレストランのid'
      t.string :name, null: false, comment: 'フードの名前'
      t.integer :price, null: false, comment: 'フードの価格'
      t.text :description, null: false, comment: 'フードの説明文'

      t.timestamps
    end
  end
end
