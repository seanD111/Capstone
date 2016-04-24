var socket = io.connect('localhost:3000');
socket.on('lastPredict', function(data){
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
	      value: newData.ratios[i]
	    });
	}


	pie.updateProp("data.content", data);
}

console.log(pie)




