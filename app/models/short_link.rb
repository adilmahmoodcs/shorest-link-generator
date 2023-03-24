class ShortLink < ApplicationRecord
  include UrlValidator

  before_create :set_shortner_path
  after_commit :fetch_title, on: :create

  private

  def set_shortner_path 
    self.shortner_path = LinkShortnerService.call
  end

  def fetch_title
    FetchUrlTitleJob.perform_later(self.id)
  end
end