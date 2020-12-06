class DelImageColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :image_name, :text
  end
end
