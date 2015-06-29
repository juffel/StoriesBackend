module AudioHelper
  def self.download_path_mp3 id
    download_path(id) + ".mp3"
  end
  def self.download_path_3gp id
    download_path(id) + ".3gp"
  end
  def self.file_path_mp3 id
    file_path(id) + ".mp3"
  end
  def self.file_path_3gp id
    file_path(id) + ".3gp"
  end

  private
  def self.download_path id
    "/audios/" + id.to_s
  end
  def self.file_path id
    Rails.root.to_s + "/public/" + download_path(id)
  end
end
