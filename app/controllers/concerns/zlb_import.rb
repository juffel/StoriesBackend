# this method imports all Stories from the Großstadtgeschichten-Portal
module ZLBImport
  def self.import
    stories_json = get_stories_json

    stories_json.each do |json|
      id = json['id']
      # add story if this story is not already in database
      unless Story.where(zlb_id: id).exists?
        story = Story.new
        # add attributes
        story.zlb_id = id
        story.save
      end
    end
  end

  private
  # retrieves the json data from 'http://grossstadtgeschichten-berlin.de/api/items'
  def self.get_stories_json
    require 'net/http'
    require 'json'

    # get stories json object
    url = URI.parse('http://grossstadtgeschichten-berlin.de/api/items')
    res = Net::HTTP.get_response(url)
    stories = JSON.parse(res.body)
  end
end
