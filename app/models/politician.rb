class Politician < ActiveRecord::Base
  attr_accessible :title, :short_title, :first_name, :last_name,
                  :party, :twitter, :fec_id, :active

  has_many :politician_problems
  has_many :problems, :through => :politician_problems

  has_many :politician_users
  has_many :users, :through => :politician_users

  has_one :widget

  #validates :fec_id, :presence => true, :uniqueness => true, :if => Proc.new{ |p| p.active == true }
  validates :title, :short_title, :first_name, :last_name, :party, :presence => true

  def self.active
    where(:active => true)
  end

  def self.with_problems
    where(:active => true).select { |pol| pol.has_problems? }
  end

  def self.members_of_congress
    where('title <> ?', "Mayor").where('title <> ?', "Governor").sort_by{|p|p.first_name}.map{|p| [p.name,p.id]}
  end

  def self.governors
    where(:title => "Governor").sort_by{|p|p.first_name}.map{|p| [p.name,p.id]}
  end

  def self.mayors
    where(:title => "Mayor").sort_by{|p|p.first_name}.map{|p| [p.name,p.id]}
  end

  def has_problems?
    problems.present?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def first_initial
    "#{first_name[0]}."
  end

  def initials
    "#{first_name[0]}#{last_name[0]}".downcase
  end

end