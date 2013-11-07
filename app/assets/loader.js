// Load the application scripts
var _runLoader = function() {
  // Create a script element to add to DOM
  var element = document.createElement("script");
  element.type = 'text/javascript';
  element.src = '/app.js';
  document.body.appendChild(element);
};

// Standard
if (window.addEventListener != null) {
  window.addEventListener("load", _runLoader, false);
// IE
} else if (window.attachEvent != null) {
  window.attachEvent("onload", _runLoader);
// Old school
} else {
  window.onload = _runLoader;
}
