# AJAX with a rails app

## Getting started

Start a new rails project by running the following commands:

1. `rails new ajax_app`
2. `cd ajax_app`
3. `rails g scaffold post title content`

#3 is something we haven't seen before. It generates the scaffolding for a resource. Which means that it makes all the things nessecary for CRUD on a single resource (i.e. model, controller, and views)

Once everything here is done we're ready to move on. To do this run `rake db:migrate` and then `rails s` and the go to [http://localhost:3000/posts](http://localhost:3000/posts) in your browser.

Take some time to create a couple posts.

## Access posts with jQuery (20 min)

In your browser open up the javascript console by typing `Command-Option-j`. Then in your browser console use the `$.getJSON` jQuery method to make a get request and console log the results. Feel free to use the following code as a template.

```js
$.getJSON(url, function(resp){
	// Code goes in here
});
```

Use the template code above to make get requests `/posts` and `/posts/:id` (be sure to replace the `:id` with an actual id). Instead of logging the JSON data that we get back try logging each of the individual fields.

**Bonus:** Append the responses you get back to the page using jQuery.

## Creating posts with jQuery

In your browser console make a `POST` using the `$.post` method. Here is some template code for making that post request.

**Note:** The url must end it `.json` in order to get json data back. Try not putting it there and see what happens.

**Note:** the `data` parameter must be of the form
```js
 {
 	post: {
 		title: "helloo",
 		content: "Booo"
 	}
 }
 ```

 Template code here:

```js
$.post(url, data, function(resp) {
	// Code goes in here
});
```

To verify that you're actually creating new posts refresh your page.

**Bonus:** Append the new post to the page using jQuery.

## Deleting use AJAX

In your browser console make a `DELETE` request using the jQuery `$.ajax` method.

```js
var req = {url: "/URL_GOES_HERE.json", type: "DELETE"};

$.ajax(req, function(resp) {
 console.log(resp);
});
```

After each call to delete be sure to refesh your page to observe the results.

**Bonus:** Remove the post specified from the page.

## Updating 

In your browser console make a `PUT` request using the jQuery `$.ajax` method.

```js
var req = {
	url: "/posts/8.json",
	type: "PUT",
	data: {
		post: {
			title: "SOME STRING HERE",
			content: "lame"
		}
	}
};

$.ajax(req, function(resp) {
 console.log(resp);
});
```

**Bonus:** Update the post specified on the page.




