class CreateGmfCorePlayers < ActiveRecord::Migration
  def change
    create_table :gmf_core_players do |t|
      t.string :name

      t.timestamps
    end
  end
end
