# FilmLocations

I looked into how to get the location database in a better format. Found on the 
https://data.sfgov.org/Culture-and-Recreation/Film-Locations-in-San-Francisco/yitu-d5am
Shorter json delivered format: https://data.sfgov.org/resource/wwmu-gmzc.json

Use codable with swift 4 for json parsing
http://www.json4swift.com/results.php for generating model

One tableview in a navigationcontroller
Added a mapview in a uiviewcontroller to show the annotation

First tried using normal search for the locations, unfortunately the formatting of the locations are very
varied in quality and format. I tried using the MKLocalSearchRequest instead which has a natural language
search that performs a bit better. To avoid getting locations in Utah etc, I look at the coordinate when it
comes back from search and discard it if it's not within a reasonable distance from SF. I also zoom in on the
map to show the pin better.

I have decided to not use xibs or storyboards, since we don't use it at my current job and I'm a bit rusty on that.
Using layoutanchors is working pretty well, too.
