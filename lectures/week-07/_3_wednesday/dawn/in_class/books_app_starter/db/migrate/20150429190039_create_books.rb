class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title

      t.timestamps null: false

      # Foreign Key
      t.references :author
    end
  end
end
