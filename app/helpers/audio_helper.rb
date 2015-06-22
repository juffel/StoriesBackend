module AudioHelper
  def self.download_path id
    "/audios/" + id.to_s + ".3gp"
  end
end
