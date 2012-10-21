class CreateGmfCoreUnits < ActiveRecord::Migration
  def change
    create_table :gmf_core_units do |t|

      t.timestamps
    end
  end
end
