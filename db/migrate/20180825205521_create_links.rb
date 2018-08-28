class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :url
      t.string :slug
      t.integer :uses, default: 0
      t.boolean :expired, default: false
      t.timestamps
    end
  end
end
