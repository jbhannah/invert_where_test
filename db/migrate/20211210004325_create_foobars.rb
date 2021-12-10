class CreateFoobars < ActiveRecord::Migration[7.0]
  def change
    create_table :foobars do |t|
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
