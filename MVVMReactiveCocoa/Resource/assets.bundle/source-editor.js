function getExtension(name) {
  if (!name)
    return null;

  var lastDot = name.lastIndexOf(".");
  if (lastDot == -1 || lastDot + 1 == name.length)
    return null;
  else
    return name.substring(lastDot + 1).toLowerCase();
}

function updateWidth() {
  var lines = document.getElementsByClassName("CodeMirror-lines")[0];
  if (lines) {
    var root = document.getElementsByClassName("CodeMirror")[0];
    if (root && lines.scrollWidth > lines.clientWidth)
      root.style.width = lines.scrollWidth + "px";
  }
}

function loadImage(type, content) {
  var img = document.createElement("img");
  img.setAttribute("src", "data:image/" + type + ";base64," + content);
  document.body.appendChild(img);
}

function connectWebViewJavascriptBridge(callback) {
  if (window.WebViewJavascriptBridge) {
    callback(WebViewJavascriptBridge)
  } else {
    document.addEventListener("WebViewJavascriptBridgeReady", function() {
      callback(WebViewJavascriptBridge)
    }, false)
  }
}

connectWebViewJavascriptBridge(function(bridge) {
  bridge.callHandler("getInitDataFromObjC", {}, function(response) {
    var title = response["title"];

    var extension = getExtension(title);
    if ("png" == extension || "gif" == extension) {
      loadImage(extension, response["Base64String"]);
      return;
    } else if ("jpg" == extension || "jpeg" == extension) {
      loadImage("jpeg", response["Base64String"]);
      return;
    }

    CodeMirror.modeURL = "mode/%N/%N.js";

    var config = {};
    config.value = response["UTF8String"];
    config.readOnly = "nocursor";
    config.lineNumbers = true;
    config.autofocus = false;
    config.lineWrapping = !!response["lineWrapping"];
    config.dragDrop = false;
    config.fixedGutter = false;

    var editor = CodeMirror(document.body, config);

    var mode, spec;

    var info = CodeMirror.findModeByExtension(extension);
    if (info) {
      mode = info.mode;
      spec = info.mime;
    }

    if (mode) {
      editor.setOption("mode", spec);
      CodeMirror.autoLoadMode(editor, mode);
    }

    if (!config.lineWrapping) updateWidth();
  })

  var uniqueId = 1;
  bridge.init(function(message, responseCallback) {
    var data = { "Javascript Responds": "Wee!" };
    responseCallback(data);
  })
})
