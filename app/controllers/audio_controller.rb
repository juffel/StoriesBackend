class AudioController < ApplicationController
  def put_here
    audio = params[:file]
    story = Story.new

    # save audio file in filesystem so it can be served statically
    # file access src: http://stackoverflow.com/a/1678388/1870317
    name = story.id.to_s + ".3gp"
    directory = "public/audios"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(audio.read) }

    # set response as (probably invalid) xml
    xml = story.token

    render :xml => xml, :status => 200
  end
end
