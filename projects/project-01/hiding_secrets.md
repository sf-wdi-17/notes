**Create .env file vars like these**

FB_API_KEY=thisistheapikeythinggoeshere

FB_API_ID=thisissomeidagwehqrwligu23liug24kbjfwe

**In bash, run**
```bash
export FB_API_KEY=thisistheapikeythinggoeshere
export FB_API_ID=thisissomeidagwehqrwligu23liug24kbjfwe
```

**Tell git to ignore .env file**
```bash
echo ".env" >> .gitignore
```

**On your server (in JavaScript), you can now say:**
```javascript
var env = process.env;
var api_key = env.MY_API_KEY;

var myFn = function(someUrl) {
  request(someUrl+"?key="+api_key);
};
```

**To set these secret variables on Heroku, you can do:**
```bash
heroku config:set FB_API_KEY=thisistheapikeythinggoeshere
```
