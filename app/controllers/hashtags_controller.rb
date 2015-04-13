class HashtagsController < ApplicationController
  def popular
    hashtags = Hashtag.joins(:twoots_tags)
              .select('hashtags.name, count(hashtag_id) as "hashtag_count"')
              .group("hashtags.id")
              .order('hashtag_count desc')
              .limit(10)
    tags = hashtags.map { |tag| tag.name }
    render json: tags.to_json
  end

  private

  def hashtag_params
    params.require(:hashtag).permit(:name)
  end
end