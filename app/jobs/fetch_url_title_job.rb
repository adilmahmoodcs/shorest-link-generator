class FetchUrlTitleJob < ApplicationJob
  queue_as :default

  def perform(id)
    short_link = ShortLink.find(id)
    short_link.update(title: FetchUrlTitle.new(short_link.original_url).fetch)
  end
end