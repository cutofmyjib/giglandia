# giglandia
A small app that lets a user:
- sign in or sign up
- follow a band or bands
- lets user see a band's upcoming shows
FYI: this is a very slow app!!!

[Check it out here](http://giglandia.herokuapp.com/)

I used Jquery mobile to get the look up and running. I used the [Songkick API](http://www.songkick.com/developer) to get information about artists. This app used to call the Echonest API but Spotify bought it and now it's not free.


## run locally
```
gem install bundler

bundle install ??

shotgun config.ru

localhost:9393
```

### heroku notes:
need procfile to deploy to heroku

run `heroku logs` to see logs
use `heroku config:set ...` for env vars
`heroku restart`
`heroku pg:reset DATABASE_URL`


