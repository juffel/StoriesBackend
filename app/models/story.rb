class Story < ActiveRecord::Base
  before_create :set_token

  private
  def set_token
    self.token = new_token 3
  end

  # generates a new, unused idtoken string that is composed of 3 letters
  # partly taken from http://stackoverflow.com/a/88341/1870317
  def new_token k
    # generate new tokens until a yet-unused one is found
    loop do
      token = (1..k).map{(65 + rand(26)).chr}.join
      # check if this token is already used
      if (Story.where(token: token).size == 0)
        return token
      end
    end
  end
end
