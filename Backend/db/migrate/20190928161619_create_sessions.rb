class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.belongs_to :classroom
      t.string :title
      t.string :description
      t.string :status
    end
  end
end
