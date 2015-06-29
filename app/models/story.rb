class Story < ActiveRecord::Base
  after_initialize :init
  before_destroy :delete_audios

  # returns true if this story has associated audio files in public/audios
  def has_audio?
    File.exist?(AudioHelper.file_path_mp3(self.id)) and File.exist?(AudioHelper.file_path_3gp(self.id))
  end

  private
  def init
    self.token ||= new_int_token 3
    self.narrator ||= ""
    self.place ||= ""
    self.title ||= ""
  end

  # generates a new, unused idtoken string that is composed of 3 letters
  # inspired by new_char_token
  def new_int_token k
    # generate new tokens until a yet-unused one is found
    loop do
      token = (1..k).map{rand(10).to_s}.join
      # check if this token is already used
      if (Story.where(token: token).size == 0)
        return token
      end
    end
  end

  # generates a new, unused idtoken string that is composed of 3 letters
  # partly taken from http://stackoverflow.com/a/88341/1870317
  def new_char_token k
    # generate new tokens until a yet-unused one is found
    loop do
      token = (1..k).map{(65 + rand(26)).chr}.join
      # check if this token is already used
      if (Story.where(token: token).size == 0)
        return token
      end
    end
  end

  # removes all audio files in public/audios/ directory associated with this story
  def delete_audios
    id = self.id
    p_3gp = 'public/' + AudioHelper.download_path_3gp(id)
    p_mp3 = 'public/' + AudioHelper.download_path_mp3(id)
    File.delete(p_3gp) if File.exists?(p_3gp)
    File.delete(p_mp3) if File.exists?(p_mp3)
  end
end
