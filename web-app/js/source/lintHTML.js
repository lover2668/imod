/* global HTMLHint */

'use strict';

// define rules for html hint
var messages = HTMLHint.verify(
	document.documentElement.innerHTML,
	{
		"attr-lowercase": true,
		"attr-no-duplication": true,
		"attr-unsafe-chars": true,
		"attr-value-double-quotes": true,
		"attr-value-not-empty": true,
		"doctype-html5": true,
		"id-class-value": "dash",
		"id-unique": true,
		"space-tab-mixed-disabled": true,
		"spec-char-escape": true,
		"src-not-empty": true,
		"tag-pair": true,
		"tagname-lowercase": true
	}
);

// if there are errors
if (messages.length > 0) {
	// add results to the end of the page
	document.documentElement.innerHTML += "<h3>HTML Validation Errors</h3><ul>";
	for (var i = 0; i < messages.length; i++) {
		var current = messages[i];
		document.documentElement.innerHTML += "<li>Line " + current.line + ": <span style='color: red;'>" + current.message + "</span>" + current.evidence.replace('<', '&lt;').replace('>', '&gt;') + "</li>";
	}
	document.documentElement.innerHTML += "</ul>";
}
