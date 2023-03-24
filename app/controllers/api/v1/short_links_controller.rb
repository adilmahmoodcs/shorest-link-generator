class Api::V1::ShortLinksController < Api::BaseController
  
  before_action :set_short_link, only: %w[show]

  api :GET, 'short_links', "Fetch first 100 most accessable short links"
  def index
    @short_links = ShortLink.limit(100).order(page_views: :desc)
  end

  api :POST, 'short_links', "Create a short link"
  param :original_url, String, desc: 'original link'
  def create
    @short_link = ShortLink.create({
      original_url: params[:original_url],
      shortner_path: LinkShortnerService.call
    })
    render_error if @short_link.blank?
  end

  def show
    ShortLinkViewedJob.perform_later(@short_link.id)
    redirect_to(@short_link.original_url, allow_other_host: true)
  end

  private

  def set_short_link
    @short_link = ShortLink.find_by(shortner_path: params[:id])
  end
end
