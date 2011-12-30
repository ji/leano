class AddProjectIdToKanban < ActiveRecord::Migration
  def change
    add_column :kanbans, :project_id, :integer
  end
end
