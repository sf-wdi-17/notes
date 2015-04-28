class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.date :enrollment_date

      t.timestamps null: false

      # Add foreign keys for many-to-many relationship
      t.references :course
      t.references :student
    end
  end
end
