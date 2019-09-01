class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.integer :e_score
      t.integer :e_percentile
      t.integer :s_score
      t.integer :s_percentile
      t.integer :g_score
      t.integer :g_percentile
      t.integer :total_score
      t.integer :total_percentile

      t.timestamps
    end
    add_index :stocks, :ticker, unique: true
  end
end
