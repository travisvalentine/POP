class Problem < ActiveRecord::Base
  attr_accessible :published_at, :body, :solution, :issue_ids, :issue_id,
                  :solutions_attributes

  validates :body, :presence  => true,
                   :length    => { :in => 20..255 }

  belongs_to :user

  has_many :solutions, :order => "up_votes DESC, created_at DESC",
                       :dependent => :destroy

  has_many :issue_problems
  has_many :issues, :through => :issue_problems

  accepts_nested_attributes_for :solutions, :issues

  make_voteable

  scope :votes, order("up_votes DESC, created_at DESC")

  def solution
    solutions
  end

  def solution=(value)
    solutions = value
  end

  def issue
    issues.first
  end

  def original_solution
    solutions.select{|s| s.original == true }.first
  end

  def other_solutions
    solutions.select{|s| s.original == false }
  end

end
