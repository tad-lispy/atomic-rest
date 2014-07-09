atomic-rest package
===================

Dirty REST API tester for [Atom Editor](http://atom.io/).

Install
-------

```shell
apm install atomic-rest
```

Use
---

In editor, type a request block like that:

```
GET http://api.twitter.com/1.1/search/tweets.json
```

Select request block and type alt-ctrl-enter to get response along with headers, like that:

```
### Response
# Headers:
{
  "content-length": "61",
  "content-type": "application/json; charset=utf-8",
  "date": "Wed, 09 Jul 2014 07:42:25 UTC",
  "server": "tfe",
  "set-cookie": [
    "guest_id=v1%3A140489174561366725; Domain=.twitter.com; Path=/; Expires=Fri, 08-Jul-2016 07:42:25 UTC"
  ],
  "connection": "close"
}
# Body:
"{\"errors\":[{\"message\":\"Bad Authentication data\",\"code\":215}]}"
###
```

You can also add a request body, formated as [CSON](https://github.com/bevry/cson/). It will be converted to JSON and appropriate headers will be set. So, assuming there is an API endpoint there:

```
POST http://api.example.com:8080/cats
  # Below and indented is your CSON formated body.
  # It's ok for it to contain comments!

  name: 'Katiusza'
  moods: [
    'playful'
    'chicky'
    'moody'
  ]

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

Notes
-----

[CSON Safe](https://github.com/groupon/cson-safe) is used for parsing request body. It has a [known issue with array of objects syntax](https://github.com/groupon/cson-safe/issues/5). You have to write them like that:

```coffeescript
cats: [
  {
    name: "Katiusza"
    mood: "Playful"
  }
  {
    name: "George"
    mood: "Weltschmerz"
  }
]
```

BTW, if you can't stand the absence of curly braces and colons, you can write strict JSON documents as a request body. Everything that is valid JSON is a valid CSON as well. So, feel at home :)

TODOs
-----

  * Automatic request block selection

    to allow triggering request with cursor inside the block, without the need to select it manually.

  * Authentication

  * Cookies

  * Response body parsing

  * Many more, probably...

Contributing
------------

Issues are more then welcome, but pull request are even more welcome :)
