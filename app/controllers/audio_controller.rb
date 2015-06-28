class AudioController < ApplicationController
  def put_here
    audio = params[:file]
    story = Story.create

    # save audio file in filesystem so it can be served statically
    # file access src: http://stackoverflow.com/a/1678388/1870317
    file_path_3gp = 'public/audios/'+story.id.to_s + '.3gp'
    file_path_wav = 'public/audios/'+story.id.to_s + '.wav'
    File.open(file_path_3gp, 'wb') { |f| f.write(audio.read) }

    # convert to mp3
    # system "ffmpeg -i #{file_path_3gp} -c:a pcm_s16le #{file_path_wav}"
    system "ffmpeg -i #{file_path_3gp} -acodec pcm_s16le -f wav -ac 2 - | lame - #{file_path_mp3}"

    # set response as (probably invalid) xml
    xml = story.token

    render :xml => xml, :status => 200
  end
end
