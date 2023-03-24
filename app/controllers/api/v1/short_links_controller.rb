class Api::V1::ShortLinksController < ApplicationController

  def index
  end

  def create
    @short_link = ShortLink.create(short_link_params)
    return render json: {link_shortner: @link_shortner.to_json}
  end

  def show
  end

  private

  def short_link_params
    params.permit(:original_url)
  end
end


(1..60).to_a.each { |s| ShortLink.create({original_url: "https://google.com"}) }