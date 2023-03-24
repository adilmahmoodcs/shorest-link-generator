class ShortLinkViewedJob < ApplicationJob
  queue_as :default

  def perform(id)
    short_link = ShortLink.find(id)
    short_link.lock!
    short_link.increment!(:page_views)
  end
end