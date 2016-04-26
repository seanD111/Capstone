var socket = io.connect('localhost:3000');
pie.data.content=[{
				"label": "Awaiting Data...",
				"value": 264131,
				"color": "#2484c1"
}]

var temp_pie = new d3pie("pieChart", pie);
socket.on('latestPredict', function(data){
	updatePie(data);

});

socket.on('updated', function(data) {
	updatePie(data);
});

function updatePie(newData){
	var data=[]
	for(var i=0; i<newData.ratios.length; i++){
		data.push({
	      label: newData.languages[i],
	      value: +newData.ratios[i]
	    });
	}
	pie.data.content=data;
	// pie.updateProp("data.content", data);
	temp_pie.destroy()
	temp_pie = new d3pie("pieChart", pie);

	console.log(data)
}






