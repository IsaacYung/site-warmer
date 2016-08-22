class ExtractUrls < ActiveRecord::Migration
  def change
    create_table :cold_urls do |t|
      t.belongs_to :warm_result
      t.string :url
      t.string :user_agent
    end

    remove_column :warm_results, :cold_urls
    remove_column :warm_results, :cold_mobile_urls
    remove_column :warm_results, :cold_tablet_urls
  end
end
