var piewidth=document.getElementById("pieChart").clientWidth; 
var pieheight=document.getElementById("pieChart").clientHeight; 
var pie = new d3pie("pieChart", {
	"header": {
		"title": {
			"text": "Language Probabilities",
			"fontSize": 24,
			"font": "open sans"
		},
		"subtitle": {
			"text": "Language prediction probabilities based on speech signal analysis",
			"color": "#999999",
			"fontSize": 12,
			"font": "open sans"
		},
		"titleSubtitlePadding": 9
	},
	"footer": {
		"color": "#999999",
		"fontSize": 10,
		"font": "open sans",
		"location": "bottom-left"
	},
	"size": {
		"canvasWidth": piewidth,
		"canvasHeight": pieheight,
		"pieInnerRadius": "20%",
		"pieOuterRadius": "90%"
	},
	"data": {
		"smallSegmentGrouping": {
			"enabled": true,
			"value": 2
		},
		"sortOrder": "value-desc",
		"content": [
			{
				"label": "Awaiting Data...",
				"value": 264131,
				"color": "#2484c1"
			}

		]
	},
	"labels": {
		"outer": {
			"pieDistance": 12
		},
		"inner": {
			"hideWhenLessThanPercentage": 2
		},
		"mainLabel": {
			"fontSize": 11
		},
		"percentage": {
			"color": "#ffffff",
			"decimalPlaces": 0
		},
		"value": {
			"color": "#adadad",
			"fontSize": 11
		},
		"lines": {
			"enabled": true
		},
		"truncation": {
			"enabled": true
		}
	},
	"effects": {
		"pullOutSegmentOnClick": {
			"effect": "linear",
			"speed": 400,
			"size": 8
		}
	},
	"misc": {
		"gradient": {
			"enabled": true,
			"percentage": 100
		}
	}
});