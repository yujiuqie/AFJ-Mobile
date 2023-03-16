ActiveConfig-SampleNodeBackend
====================================

Sample ActiveConfig backend that runs on Heroku (http://msactiveconfig-sampleapp.herokuapp.com/active_config)

## Description

This node.js app is just an example of how easy it is to create a backend
for [MSActiveConfig](https://github.com/mindsnacks/MSActiveConfig).
This particular implementation sends a response with a JSON that looks like this:

```json

{
  "meta": {
    "format_version_string": "1.0",
    "creation_time": "Sat Jul 06 2013 20:13:24 GMT+0000 (UTC)"
  },
  "config_sections": {
    "SampleViewConfiguration": {
      "settings": {
        "ViewBackgroundColor": {
          "value": {
            "red": 0.4,
            "green": 0.07,
            "blue": 0.5
          }
        },
        "LabelText": {
          "value": "This is a label value for user ID 2"
        },
        "ButtonEnabled": {
          "value": false
        }
      }
    }
  }
}
```

### To see in action, download the repo at https://github.com/mindsnacks/MSActiveConfig and check out the sample app.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/JaviSoto/activeconfig-samplenodebackend/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

