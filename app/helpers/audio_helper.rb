module AudioHelper
  def self.download_path id
    "/audios/" + id.to_s + ".mp3"
  end
end
