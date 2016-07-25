class AddMobileAndTabletUrls < ActiveRecord::Migration
  def change
    change_table :warm_results do |t|
      t.string :cold_mobile_urls, null: true, array: true
      t.string :cold_tablet_urls, null: true, array: true
    end
  end
end
