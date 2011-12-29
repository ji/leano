class AddKanbanIdToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :kanban_id, :integer
  end
end
