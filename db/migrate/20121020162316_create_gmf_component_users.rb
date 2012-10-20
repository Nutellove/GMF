class CreateGmfComponentUsers < ActiveRecord::Migration
  def change
    create_table :gmf_component_users do |t|

      t.timestamps
    end
  end
end
