class AudioController < ApplicationController
  def put_here
    byebug
    DataFile.save_file(params[:upload])
  end
end
