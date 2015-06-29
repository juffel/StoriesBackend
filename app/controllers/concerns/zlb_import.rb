# this method imports all Stories from the Großstadtgeschichten-Portal
module ZLBImport
  def self.import
    require 'net/http'
    require 'json'

    # get stories json object
    url = URI.parse('http://grossstadtgeschichten-berlin.de/api/items')
    res = Net::HTTP.get_response(url)
    stories = JSON.parse(res.body)
  end
end
