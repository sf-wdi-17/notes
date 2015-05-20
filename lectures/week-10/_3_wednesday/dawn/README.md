# Intro Angular
## Intro Custom Directives

| Objectives |
| :--- |
| utilize angular's module syntax to implement directives |
| discuss `template` attributes and directive restrictions |
| integrate custom directives into a Rails Application |


## Resources

* [Directive Lesson](https://docs.angularjs.org/guide/directive)
* [Custom Directives](http://weblogs.asp.net/dwahlin/creating-custom-angularjs-directives-part-i-the-fundamentals) 


## Notes On Rails Integration


As always getting started with Angular and Rails you should probably go to Angular's website and find the latest cdn. Then drop it into `app/views/layouts/application.html.erb`.

```
<!DOCTYPE html>
<html>
<head>
  <title>TodoSol</title>
  <!-- Note the use cdn goes at the top -->
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.12/angular.min.js"></script>

  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>


</body>
</html>

```


Be sure to have a `root` to some page where your example would be. You can also write all the corresponding `js` into your `application.js`.


To use the `templateUrl` attribute with Angular directives we wan to put remote templates in the 

`public/` folder in our rails application.


For example, using an example from resource 1 we can have the following directive

```
CustomerApp.directive('myCustomer', function() {
  return {
    templateUrl: 'my-customer.html'
  };
});

```

would have a corresponding `public` file in our Rails app.

```
public/
  my-customer.html
```


