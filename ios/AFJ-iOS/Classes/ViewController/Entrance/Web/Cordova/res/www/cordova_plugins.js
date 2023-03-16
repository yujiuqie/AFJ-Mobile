cordova.define('cordova/plugin_list', function (require, exports, module) {
    module.exports = [
        {
            "id": "cordova-plugin-wkwebview-engine.ios-wkwebview-exec",
            "file": "plugins/cordova-plugin-wkwebview-engine/src/www/ios/ios-wkwebview-exec.js",
            "pluginId": "cordova-plugin-wkwebview-engine",
            "clobbers": [
                "cordova.exec"
            ]
        },
        {
            "id": "cordova-plugin-wkwebview-engine.ios-wkwebview",
            "file": "plugins/cordova-plugin-wkwebview-engine/src/www/ios/ios-wkwebview.js",
            "pluginId": "cordova-plugin-wkwebview-engine",
            "clobbers": [
                "window.WkWebView"
            ]
        }
    ];
    module.exports.metadata =
// TOP OF METADATA
        {
            "cordova-plugin-whitelist": "1.3.3",
            "cordova-plugin-wkwebview-engine": "1.1.4"
        };
// BOTTOM OF METADATA
});