class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :website

      t.timestamps
    end
  end
end
