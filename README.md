# atomic-rest package

Dirty REST API tester.

You type a request block like that:

```
POST http://api.example.com:8080/cats
  # Below and indented is your CSON formated body.
  # It will be converted to JSON
  # Appropriate headers will be set
  name: 'Katiusza'
  moods: [
    'playfull'
    'chicky'
    'moody'
  ]
```

Inside request block type alt-ctrl-enter, and get response along with headers, like that:

```
### Response
# headers
HTTP/1.1 200 OK
X-Powered-By: Express
Vary: Accept
Content-Type: application/json; charset=utf-8
Content-Length: 19
ETag: W/"13-2838837460"
Date: Tue, 08 Jul 2014 19:06:49 GMT
Connection: keep-alive

# Body
{
  _id: 1
  name: 'Katiusza'
  moods: [
    'playfull'
    'chicky'
    'moody'
  ]

}
###
```
