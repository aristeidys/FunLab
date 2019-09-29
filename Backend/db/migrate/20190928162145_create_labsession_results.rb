class CreateLabsessionResults < ActiveRecord::Migration[5.2]
  def change
    create_table :labsession_results do |t|
      t.belongs_to :labsession
      t.belongs_to :student
      t.boolean :completed
      t.decimal :totalScore
    end
  end
end
