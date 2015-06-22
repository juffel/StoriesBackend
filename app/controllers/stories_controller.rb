class StoriesController < ApplicationController
  before_action :set_story

  def home
  end

  def index
    @stories = Story.all.reverse_order
  end

  def show
  end

  def edit
    # assign passed parameters if present
    if params['narrator'].present? or params['place'].present?
      @story.narrator = params['narrator'] unless params['narrator'].empty?
      @story.place = params['place'] unless params['place'].empty?

      redirect_to action: "show"
    end
    @story.save
  end

  def token
    # check if came from token entry, then fetch story by token
    if params['token_1'].present? and params['token_2'].present? and params['token_3'].present?
      # reassemble token
      token = ""
      token += params['token_1']
      token += params['token_2']
      token += params['token_3']
      token = token.upcase

      # TODO catch if no such id is present
      story_id = Story.where(token: token).first.id
      redirect_to action: "edit", id: story_id
    end
  end

  private

  def set_story
    if params[:id].present?
      @story = Story.find(params[:id])
    end
  end

  def self.get_zlb_stories_json
    url = URI('http://grossstadtgeschichten-berlin.de/api/items')
    req = Net::HTTP::Get.new(url)
    req.content_type = "json"
    stories = Net::HTTP.start(url.hostname, url.port) do |http|
      http.request(req)
    end
    JSON.parse stories.body
  end
end
