 1) RandomInstagramPhoto returns the latitude of a photo
     Failure/Error: Instagram.media_popular.first
     Faraday::Error::ParsingError:
       757: unexpected token at '<html>
       <head><title>504 Gateway Time-out</title></head>
       <body bgcolor="white">
       <center><h1>504 Gateway Time-out</h1></center>
       <hr><center>nginx</center>
       </body>
       </html>
       '


<p>This page will refresh every 5 seconds. This is because we're using the 'onload' event to call our function. We are passing in the value '5000', which equals 5 seconds.</p>
<p>But hey, try not to annoy your users too much with unnecessary page refreshes every few seconds!</p>