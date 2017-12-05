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

I have decided to not use xibs or storyboards, since we don't use it at my current job and I'm not a huge fan.
Using layoutanchors is working pretty well, too.

Ideas for expansion:
Search in the list for movie title
Better handling of optionals in the code (too many ! right now)
Smarter search in the maps, maybe use google lookup that might be better (or both)

Also the two optionals that was in the technical challenge
Provide a way for the user to change the sorting of the list (Right now it's too many fields to possibly search on, I feel. Might just be needed to search on title and year?)
Cache data locally using core data (it is very quick so far anyway, it seems like it is possibly updated weekly (according to the sfgov page))
