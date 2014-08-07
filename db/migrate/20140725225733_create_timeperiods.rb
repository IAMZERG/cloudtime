class CreateTimeperiods < ActiveRecord::Migration
  def change
    create_table :timeperiods do |t|
      t.text :note
      t.references :project, index: true

      t.timestamps
    end
  end
end
