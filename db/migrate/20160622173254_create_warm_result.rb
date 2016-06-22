class CreateWarmResult < ActiveRecord::Migration
  def change
    create_table :warm_results do |t|
      t.string :entry_point, null: false
      t.integer :total_urls, null: false
      t.integer :duration, null: false
      t.string :cold_urls, null: false, array: true
    end
  end
end
