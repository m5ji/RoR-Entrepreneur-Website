class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :Name
      t.text :url
      t.text :Description
      t.float :Price
      t.string :Status

      t.timestamps null: false
    end
  end
end
