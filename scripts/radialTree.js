screenH=$("#myCarousel").height();
screenW=$("#myCarousel").width();
var selectedNodes=[];
var diameter = Math.min(screenW, screenH)+100;

var tree = d3.layout.tree()
    .size([360, (diameter / 2 )]);
    // .separation(function(a, b) { return (a.parent == b.parent ? 1 : 2) / a.depth; });

var diagonal = d3.svg.diagonal.radial()
    .projection(function(d) { return [d.y, d.x / 180 * Math.PI]; });

var svgLinks = d3.select("#edpSlide").append("svg")
    .attr("width", diameter)
    .attr("height", diameter)
    .style({display: 'block' , margin: 'auto'})

  .append("g")
    .attr('class', 'linkGroup')
    .attr("transform", "translate(" + diameter / 2 + "," + diameter / 3 + ")");

var svgNodes = d3.select("body").select("svg")
  .append("g")
    .attr('class', 'nodeGroup')
    .attr("transform", "translate(" + diameter / 2 + "," + diameter / 3 + ")");

var nodes, links, dijkstraNodes=[],
  		dijkstraLinks=[];
var sp;
d3.json("data/json/combined.json", function(error, root) {
  if (error) throw error;



   	nodes = tree.nodes(root);

    links = tree.links(nodes);


      

    nodes.forEach(function(node_, i){
    	var newObj={
	      	index:i,
	      	value:node_.name
     	 }
       node_.globalI=i
     	 dijkstraNodes.push(newObj)
      })

    links.forEach(function(link){
    	var newLink={
	      	source: nodes.indexOf(link.source),
	      	target:nodes.indexOf(link.target),
	      	distance:1
      	}
      	dijkstraLinks.push(newLink)
    })

    console.log(links)





  var node = svgNodes.selectAll(".node")
      .data(nodes)
    .enter().append("g")
      .attr("class", function(d){

			"children" in d ==0 ? toreturn="endnode" : toreturn="node" 
			return toreturn
      })
    .attr('id', function(d, i){
    	return "node"+ i
    })
    .attr("transform", function(d) { 

		if(d.depth%2){
			d.x=d.x+2
		}
		else{
			d.x=d.x-2
		}
		return "rotate(" + (d.x - 90) + ")translate(" + d.y + ")"; 
	   })
    .on('click', nodeClicked)


  var link = svgLinks.selectAll(".link")
      .data(links)
    .enter().append("path")
      .attr("class", "link")
      .attr("id", function(d, i){
      	return "link"+ i
      })
      .attr("d", diagonal);

      svgLinks.append('text')
        .attr('class', 'distText')
        .attr("dy", ".31em")
        .attr("transform", "translate("+diameter*0.35+','+diameter*(-0.2)+")")
        .text('Select Nodes')



  node.append("circle")
      .attr("r", function(d){	
	if(d.depth==0){
		return 2.5;
	}
	else{
		return 4.5
	}
      });

  node.append("text")
      .attr("dy", ".31em")
      .attr("text-anchor", function(d) { return d.x < 180 ? "start" : "end"; })
      .attr("transform", function(d) { return d.x < 180 ? "translate(8)" : "rotate(180)translate(-8)"; })
      .attr("font-size", screenW/300)
      .text(function(d) { 
		if(d.depth==0){return}
		return d.name; 
	});

  sp = new ShortestPathCalculator(dijkstraNodes, dijkstraLinks);
});

function nodeClicked(d){
  switch(selectedNodes.length){
    case 0:
      selectedNodes[0]=d.globalI
      break;
    case 1:;
      selectedNodes[1]=d.globalI
      findShortRoute();
      break;
    case 2:
      selectedNodes[1]=selectedNodes[0]
      selectedNodes[0]=d.globalI
      findShortRoute();
      break;
  }

}
function findShortRoute(){

  var route = sp.findRoute(selectedNodes[0],selectedNodes[1]);
  route.path.forEach(function(shortpath){
    shortpath.source=nodes[shortpath.source]
    shortpath.target=nodes[shortpath.target]
  })
  svgLinks.selectAll(".shortlink").remove('*');
    var shortestLinks = svgLinks.selectAll(".shortlink")
      .data(route.path)
    .enter().append("path")
      .attr("class", "shortlink")
      .attr("d", diagonal)
      .style({
      'fill': 'none',
      'stroke': 'steelblue',
      'stroke-width': '2.5px'
    });

      d3.selectAll('.distText').text('Distance: '+route.distance)
}

d3.select(self.frameElement).style("height", diameter - 150 + "px");
