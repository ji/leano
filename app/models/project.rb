class Project < ActiveRecord::Base
  has_many :contributors
  has_many :users, :through => :contributors
  
  has_one :kanban
  validates_presence_of :title
  
  def belongs_to_user?(user)
    return Contributor.where(:project_id => self.id, :user_id => user.id).count > 0
  end
end
