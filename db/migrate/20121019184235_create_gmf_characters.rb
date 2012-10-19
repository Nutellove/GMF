class CreateGmfCharacters < ActiveRecord::Migration
  def change
    create_table :gmf_characters do |t|
      t.string :name

      t.timestamps
    end
  end
end
