class ShortLink < ApplicationRecord
  include UrlValidator

  validates :shortner_path, presence: true, uniqueness: true

  after_commit :fetch_title, on: :create

  private

  def fetch_title
    FetchUrlTitleJob.perform_later(self.id)
  end
end
