class TicketmasterApi < ApplicationRecord
  def self.handle_ticketmaster_API(partial_url)
    api_key = "apikey=VIxfWLncF71QZ3aoc9OLoeGU9NnAsVRj"
    uri = "https://app.ticketmaster.com/discovery/v2/events.json?"
    url = "#{uri}#{api_key}#{partial_url}"

    response = HTTP.get(url)
    if JSON.parse(response.body)["page"]["totalElements"] == 0
       return {json: { error: "No concerts for this artist yet"}, status: 404}
    end
    events = JSON.parse(response.body)["_embedded"]["events"]
    @concerts = []
    events.each do |event|
      concert = {
        name: event["name"],
        date: event["dates"]["start"]["localDate"],
        url: event["url"],
        concert_id: event["id"]
      }
      if event["classifications"]
        concert["genre"] = event["classifications"][0]["genre"]["name"]
        concert["subgenre"] = event["classifications"][0]["subGenre"]["name"]
      end

      if (event["_embedded"]["venues"][0]["country"] && event["_embedded"]["venues"][0]["location"])
        concert["country"] = event["_embedded"]["venues"][0]["country"]["countryCode"]
        concert["lat"] = event["_embedded"]["venues"][0]["location"]["latitude"]
        concert["lon"] = event["_embedded"]["venues"][0]["location"]["longitude"]
        concert["city"] = event["_embedded"]["venues"][0]["city"]["name"]
        concert["venue"] = event["_embedded"]["venues"][0]["name"]
      end

      if event["dates"]["status"]["code"] == "onsale"
        concert["sale"] = true
      else
        concert["sale"] = false
      end

      event["images"].each do |image|
        concert["image"] =  image["url"] if image["ratio"] == "16_9"
      end
      @concerts.push(concert);
    end
    return {json: @concerts, status: 200}
  end
end