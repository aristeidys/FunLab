class AddLabSessionsReferenceToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :lab_session, foreign_key: true
  end
end
