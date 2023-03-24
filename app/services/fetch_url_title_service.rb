require 'open-uri'
class FetchUrlTitleService
  def initialize(url)
    @url = url
  end

  def fetch
    doc = Nokogiri::HTML(URI.open(url))
    doc.title || ''
  end

  private
  attr_reader :url
end