class StoriesController < ApplicationController
  before_action :set_story

  def home
    @newest = Story.last
  end

  def index
    @stories = Story.all.reverse_order
  end

  def show
  end

  def edit
    # assign passed parameters if present
    if params['narrator'].present? or params['place'].present?
      @story.title = params['title'] unless params['title'].empty?
      @story.narrator = params['narrator'] unless params['narrator'].empty?
      @story.place = params['place'] unless params['place'].empty?
      @story.text = params['text'] unless params['text'].empty?

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

      story = Story.where(token: token).first
      if story.present?
        story_id = story.id
        redirect_to action: "edit", id: story_id
      else
        params.delete "token_1"
        params.delete "token_2"
        params.delete "token_3"
        redirect_to action: "token"
      end
    end
  end

  # returns the resource path (url) for a randomly chosen story
  def random
    @story = Story.order("RAND()").first
    url = AudioHelper.download_path(@story.id)
    render :xml => url, :status => 200
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
