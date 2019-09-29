class CreateSessionResults < ActiveRecord::Migration[5.2]
  def change
    create_table :session_results do |t|
      t.belongs_to :session
      t.belongs_to :student
      t.boolean :completed
      t.integer :totalScore
    end
  end
end
