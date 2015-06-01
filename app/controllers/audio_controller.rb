class AudioController < ApplicationController
  def put_here
    # simply save new story
    audio = params[:file]
    Story.new({audio: audio.read}).save

    render :nothing => true, :status => 200
  end
end
