class CreatePixels < ActiveRecord::Migration[5.1]
  def change
    create_table :pixels do |t|
      t.integer :count, default: 0
      t.timestamps
    end
  end
end
