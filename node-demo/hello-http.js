var http = require('http');
http.createServer(function (req, res) {
    var now = new Date();
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end('HOLA from Node.js! ' + now.toJSON() + ' on ' + process.env.HOSTNAME  + '\n');
    
}).listen(8000, '0.0.0.0');
console.log('Server running at http://:8000/');
