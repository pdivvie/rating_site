class RemoveRatingsFromBusinesses < ActiveRecord::Migration[5.2]
  def change
    remove_column :businesses, :rating, :integer
  end
end
