class Widget < ActiveRecord::Base
  belongs_to :politician

  include Rails.application.routes.url_helpers

  attr_accessible :politician_id, :size

  validates :politician_id, presence: true, uniqueness: true

  belongs_to :politician

  def embed_link
    embed_url(self, format: :js, host: RAW_URL)
  end

  def embed_code
    "<script type='text/javascript' src='#{embed_link}'></script>"
  end

end
