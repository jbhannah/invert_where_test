class AddPublishedToFoobars < ActiveRecord::Migration[7.0]
  def change
    add_column :foobars, :published, :boolean, default: false
  end
end
