class AddPointsToEnrolments < ActiveRecord::Migration[5.2]
  def change
    add_column :enrolments, :points, :bigint
  end
end
