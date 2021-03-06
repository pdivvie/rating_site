class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :display_in_navbar, default: true

      t.timestamps
    end
  end
end
