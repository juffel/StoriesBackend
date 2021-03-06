class StoriesController < ApplicationController
  before_action :set_story

  def home
    @newest = Story.last || Story.new(id: -1, title: "Dummy")
  end

  def index
    @stories = Story.order('created_at DESC')
  end

  def show
  end

  def edit
  end

  def update
    @story.update!(story_params)
    redirect_to action: "show"
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
        redirect_to action: 'edit', id: story_id
      else
        params.delete 'token_1'
        params.delete 'token_2'
        params.delete 'token_3'
        redirect_to action: 'token'
      end
    end
  end

  # redirects to a random story view
  def rnd
    @story = Story.order('RAND()').first
    redirect_to action: 'show', id: @story.id
  end

  # returns the resource path (url) for a randomly chosen story's audio
  # only stories with audio are chosen randomly
  def random
    audio_stories = Story.all.select{ |s| s.has_audio? }
    @story = audio_stories[Random.rand(audio_stories.size)]
    url = AudioHelper.download_path_3gp(@story.id)
    render :xml => url, :status => 200
  end

  # returns a boolean value wether the token of a story has been entered and
  # some attribute of this story has been changed
  # expects a param "token" to be set
  def token_entered
    @story = Story.where(token: params[:token]).first
    if @story.title != "" or @story.narrator != "" or @story.place != ""
      render :xml => 'true', :status => 200
    else
      render :xml => 'false', :status => 404
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :narrator, :place, :text)
  end

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
