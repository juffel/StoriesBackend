class StoriesController < ApplicationController
  def index
    @stories = Story.all.reverse_order
  end

  def show
  end
end
