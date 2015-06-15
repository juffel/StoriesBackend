class AudioController < ApplicationController
  def put_here
    # simply save new story
    audio = params[:file]
    story = Story.create({audio: audio.read})

    # set response as (probably invalid) xml
    xml = story.token

    render :xml => xml, :status => 200
  end

  def download
    content = Story.find(params[:id]).audio
    send_data content, :filename=>'recording.3gp', :type=>'application/audio', :disposition=>'attachment'
  end
end
