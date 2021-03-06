# Film-parser

Takes a spesific HTML file and parses out all the films you have watched. 
The output is shown in the terminal like this..

```
Anima [2019]
Apollo 11 [2019]
The Grand Budapest Hotel [2014]
12 Angry Men [1957]
The Royal Tenenbaums [2001]
They Shall Not Grow Old [2018]
La Meglio Gioventù AKA The Best of Youth [2003]
Gone Girl [2014]
Hearts of Darkness: A Filmmaker's Apocalypse [1991]
Lawrence of Arabia [1962]
...
```

# How to use
`./film-parser file.html [options]`

# Optional Arguments
`--score` Shows the score for each movie. If there is none, 'Seen' is displayed.

`--imdb` Appends the IMDb tag for each movie. Example: (tt0092550).

`--only_imdb` Overrides the other arguments and displays only the IMDb tags.

`--json` Writes to json file.

# JSON format

``` json
{
  "name": "Films watched 5 9 2020",
  "films": [
        {
         "title": "Anima",
         "year": "2019",
         "score": "100",
         "imdb": "tt10516984"
        },
        {
         "title": "Apollo 11",
         "year": "2019",
         "score": "100",
         "imdb": "tt8760684"
        },
        {
         "title": "The Grand Budapest Hotel",
         "year": "2014",
         "score": "100",
         "imdb": "tt2278388"
        },
        ...
  ]
}
```
