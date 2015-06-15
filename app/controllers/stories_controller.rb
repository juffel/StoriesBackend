class StoriesController < ApplicationController
  def index
    @stories = Story.all.reverse_order
  end

  def show
  end

  def edit
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
end
