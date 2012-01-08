class Issue < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true
  
  def owned_by?(owner)
    return false unless owner.is_a? User
    user == owner
  end

end
