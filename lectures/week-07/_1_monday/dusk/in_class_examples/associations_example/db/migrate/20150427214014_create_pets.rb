class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name

      t.timestamps null: false

      # Adding foreign key
      t.references :owner
    end
  end
end
