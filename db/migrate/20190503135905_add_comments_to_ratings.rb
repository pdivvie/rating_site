class AddCommentsToRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :comment, :text
  end
end
