class UpdateTagRelations < ActiveRecord::Migration
  def up
    create_table :user_stories_user_story_tags do |t|
      t.integer :user_story_id
      t.integer :user_story_tag_id
    end
    
    remove_column :user_story_tags, :user_story_id
    add_column :user_story_tags, :project_id, :integer
  end
  
  def down
    drop_table :user_stories_user_story_tags
    remove_column :user_story_tags, :project_id
    add_column :user_story_tags, :user_story_id, :integer
  end
end
