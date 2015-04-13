class TwootsController < ApplicationController
  before_action :set_twoot, only: [:show, :edit, :update, :destroy]

  def recent
    Twoot.ordered_json
    twoots = Twoot.ordered_json
    render json: twoots
  end

  def search
    hashtag = Hashtag.where(name: params[:keyword]).first
    if hashtag
      render json: hashtag.twoots.ordered_json
    else
      render :nothing => true, status: 404
    end
  end

  def create
    twoot = Twoot.new(params[:twoot])
    twoot.content ||= Faker::Lorem.sentence
    twoot.username ||= Faker::Name.name
    twoot.handle ||= "@" + Faker::Internet.user_name
    twoot.avatar_url ||= Faker::Avatar.image(twoot.username)
    twoot.save

    hashtags_names = params[:hashtags] || []
    hashtags_names.each do |name|
      twoot.hashtags << Hashtag.first_or_create(name: name)
    end

    render json: twoot.to_json(methods: :hashtag_names)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twoot
      @twoot = Twoot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twoot_params
      params.require(:twoot).permit(:body, :username, :handle, :avatar_url)
    end
end
