class AddDraftToLabSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_sessions, :draft, :boolean
  end
end
