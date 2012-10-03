class Politician < ActiveRecord::Base
  attr_accessible :title, :first_name, :last_name, :party, :twitter
  has_and_belongs_to_many :problems
  has_and_belongs_to_many :users

  def self.create_from_address(address)
    response = Sunlight::Legislator.all_for(:address => address)
    response.each_pair do |k,v|
      if v
        create(:title      => k.humanize.titleize,
               :first_name => v.firstname,
               :last_name  => v.last_name,
               :party      => v.party,
               :twitter    => v.twitter_id)
      end
    end
  end

end
