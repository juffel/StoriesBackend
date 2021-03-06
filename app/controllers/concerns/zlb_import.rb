# this method imports all Stories from the Großstadtgeschichten-Portal
module ZLBImport
  def self.import
    stories_json = get_stories_json

    # TODO remove this statement, only for development purposes
    Story.all.each do |s|
      if s.zlb_id.present?
       s.destroy
      end
    end
    # END TODO

    # filter for item_type 26 "Geschichte BGG" (http://grossstadtgeschichten-berlin.de/api/item_types/26)
    stories_json.each do |json|
      if json['item_type']['id'] == 26
        id = json['id']

        # add story if this story is not already in database
        unless Story.where(zlb_id: id).exists?
          story = Story.new
          # add attributes
          story.zlb_id = id

          texts = json['element_texts']

          # the associated text elements are not ordered by id/type but in a linear
          # fashion with type_ids contained in child nodes, so every text element
          # has to be scanned for their type_ids
          texts.each do |text|
            type = text['element']['id']
            content = text['text']
            case type
            when 50 # Titel der Geschichte
              story.title = content
            when 79 # Beschreibungstext
              story.text = content
            when 70 # Datum der Aufnahme
              # assumes date format DD.MM.YYYY
              story.created_at = Date.strptime(content, '%d.%m.%Y')
            end
          end
          story.save
        end
      end
    end
  end

  # retrieves the json data from 'http://grossstadtgeschichten-berlin.de/api/items'
  def self.get_stories_json
    require 'net/http'
    require 'json'

    stories = []

    # per default the first 50 item are returned
    # http://grossstadtgeschichten-berlin.de/api/items?page=1&per_page=50
    # so get total number at first and then iterate through pages
    url = URI.parse('http://grossstadtgeschichten-berlin.de/api/items')
    total_count = Integer(Net::HTTP.get_response(url)["omeka-total-results"])

    # iterate over 50 pages
    per_page = 50
    page = 0
    (1..total_count).step(per_page) do |n|
      page += 1
      url.query = 'page=' + page.to_s
      # get stories json object
      res = Net::HTTP.get_response(url)
      stories += JSON.parse(res.body)
    end
    stories
  end
end
