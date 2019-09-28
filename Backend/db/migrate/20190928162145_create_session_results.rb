class CreateSessionResults < ActiveRecord::Migration[5.2]
  def change
    create_table :session_results do |t|
      t.boolean :completed
      t.decimal :totalScore
    end
  end
end
