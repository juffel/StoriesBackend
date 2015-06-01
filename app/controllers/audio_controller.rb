class AudioController < ApplicationController
  def put_here
    # simply save new story
    audio = params[:file]
    Story.new({audio: audio.read}).save

    render :nothing => true, :status => 200
  end

  def download
    content = Story.find(params[:id]).audio
    send_data content, :filename=>'recording.3gp', :type=>'application/audio', :disposition=>'attachment'
  end
end
