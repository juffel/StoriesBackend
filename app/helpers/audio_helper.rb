module AudioHelper
  def self.download_path_mp3 id
    download_path(id) + ".wav"
  end
  def self.download_path_3gp id
    download_path(id) + ".3gp"
  end

  private
  def self.download_path id
    "/audios/" + id.to_s
  end
end
