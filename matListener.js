var express = require('express');
var fs = require('fs');
var app = express();
var lastPredict;

var io = require('socket.io')(app.listen(3000));
io.on('connection', function(socket) {

		socket.emit('latestPredict', lastPredict);


        fs.watch('data', function(event, filename) {
            fs.readFile('data/' + filename, function(err, data) {
                if (!err) {
                    try {
                       
                        var x = JSON.parse(data);
                        lastPredict=x;
                        socket.emit('updated', x);

                    } catch (e) {
                        console.log('malformed data');
                    }


                }
            })
        });
});