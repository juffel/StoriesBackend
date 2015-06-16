class AudioController < ApplicationController
  def put_here
    # simply save new story as activerecord
    audio = params[:file]
    story = Story.create({audio: audio.read})

    # also save audio file in filesystem so it can be served statically
    # file access src: http://stackoverflow.com/a/1678388/1870317
    name = "story_" + story.id.to_s + ".3gp"
    directory = "public/audios"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(audio.read) }

    # set response as (probably invalid) xml
    xml = story.token

    render :xml => xml, :status => 200 
  end 

  def download
    content = Story.find(params[:id]).audio
    send_data content, :filename=>'recording.3gp', :type=>'application/audio', :disposition=>'attachment'
  end 
end
