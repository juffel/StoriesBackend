class AudioController < ApplicationController
  def put_here
    audio = params[:file]
    story = Story.create

    # save audio file in filesystem so it can be served statically
    # file access src: http://stackoverflow.com/a/1678388/1870317
    file_path = Rails.root.join('public', 'audios', story.id.to_s + '.3gp')
    File.open(file, 'wb') { |f| f.write(audio.read) }

    # set response as (probably invalid) xml
    xml = story.token

    render :xml => xml, :status => 200
  end
end
