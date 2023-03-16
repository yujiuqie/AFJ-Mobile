var express = require("express");
var app = express();
app.use(express.logger());

app.get('/active_config', function (request, response) {
    var user_id = parseInt(request.query.userID)

    response.send({
        meta: {
            format_version_string: "1.0",
            creation_time: new Date().toString(),
        },
        config_sections: {
            SampleViewConfiguration: {
                settings: {
                    ViewBackgroundColor: {
                        value: {
                            red: user_id ? Math.sin(45 / user_id) / user_id : 0,
                            green: user_id ? Math.cos(30) / user_id : 0,
                            blue: user_id ? 1 / user_id : 0,
                        }
                    },
                    LabelText: {
                        value: "This is a label value for user ID " + user_id
                    },
                    ButtonEnabled: {
                        value: (user_id == 3)
                    }
                }
            }
        }
    })
});

var port = process.env.PORT || 5000;
app.listen(port, function () {
    console.log("Listening on " + port);
});