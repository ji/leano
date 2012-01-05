class AddColumnIdToUserStory < ActiveRecord::Migration
  def change
    add_column :user_stories, :column_id, :integer
  end
end
