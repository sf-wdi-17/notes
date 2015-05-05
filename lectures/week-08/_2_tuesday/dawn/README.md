# INTRO SPA

### Part 1: Setup

```bash
rails new spa_ex -T && cd spa_ex
```

Generating models:

* We need a `Todo` model with `content:text` and `completed:boolean`.
  * `rails g model todo content:text completed:boolean`

Generating routes:

* We need resources for `:todos`
* We need to `root` to the `todos#index`.

Generating controllers:

* We need a `todos` controller with an `index` page, i.e.
  * `rails g controller todos index`

**Don't forget to `rake db:migrate`**

### Part 2: JSON API

Now we need to setup our `todos#index` method to serve both `html` and `json` for `todos`.


```ruby
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html
      format.json { render json: @todos }
    end
  end
```

**NOTE: If you haven't yet, you should go into your `rails console` and try to make a `todo` so that it can show up...**

Go to [`localhost:3000/todos.json`](localhost:3000/todos.json) and verify this is working correctly as a `JSON` endpoint.


We also should make our `todos/index.html.erb` have a `todos-con` to hold our `todos`.

```html
<div id="todos-con">
</div>
```


In the `app/assets/javascripts/application.js` we need to add our JS for loading all the `todos`.


**NOTE: If you haven't yet, you should go into your `rails console` and try to make a `todo` so that it can show up...**

`app/assets/javascripts/application.js`
```js
// wait for window load
$(function () {
    $.get("/todos.json")
      .done(function (todos) {
        console.log("All Todos:", todos);
      });
});
```

Then we want to use `jQuery` to `append` the `todo` the page.

```js
// wait for window load
$(function () {
  
  // grab the `todos-con`
  var $todosCon = $("#todos-con");
  
  $.get("/todos.json")
    .done(function (todos) {
      console.log("All Todos:", todos);

      // append each todo
      todos.forEach(function (todo) {
        $todosCon.append("<div>" +  todo.content + "</div>");
      });

    });

});

```

### Creating 

Let's modify our `todos/index.html.erb` to have a form for a `todo`.

Make a note here to add the `@todo` to our `index` method

```ruby
  def index
    @todos = Todo.all
    @todo = Todo.new

    respond_to do |format|
      format.html
      format.json { render json: @todos }
    end
  end
```

and also do the following:


```html
	
	<%= form_for @todo  do |f| %>
	  <%= f.text_field :content, placeholder: :content %>
	  <%= f.submit %>
	<% end %>
	
	<div id="todos-con">
	</div>


```

Note that if you view page on the `localhost:3000` you should see that the form has `new_todo` as an id.
Editing

Let's wait for the submit event from the form. Then we should `preventDefault()` on the form.

`app/assets/javascripts/application.js`
```js
  var $todoForm = $("#new_todo");

  $todoForm.on("submit", function (event) {
    event.preventDefault();
    console.log($(this).serialize());
  });

```

All in all we have the following:
`app/assets/javascripts/application.js`
```js

// wait for window load
$(function () {
  
  // grab the `todos-con`
  var $todosCon = $("#todos-con");
  
  $.get("/todos.json")
    .done(function (todos) {
      console.log("All Todos:", todos);

      // append each todo
      todos.forEach(function (todo) {
        $todosCon.append("<div>" +  todo.content + "</div>");
      });

    });

  var $todoForm = $("#new_todo");

  $todoForm.on("submit", function (event) {
    event.preventDefault();
    console.log("Form submitted", $(this).serialize());
  });

});

```


Now that our form is submitted, we can add the in the logic to `post` the data to our backend and render it to the page.


`app/assets/javascripts/application.js`
```js
$todoForm.on("submit", function (event) { 
  event.preventDefault();
  console.log("Form submitted", $(this).serialize());

  var content = $("#todo_content").val();
  $.post("/todos.json", {
    todo: {
      content: content
    }
  }).done(function (createdTodo) {
    $todosCon.append("<div>" + createdTodo.content + "</div>")
  });
});


```

All together we have the following, but keep in mind we still need to write some todo logic in our controller.

`app/assets/javascripts/application.js`
```js

// wait for window load
$(function () {
  
  // grab the `todos-con`
  var $todosCon = $("#todos-con");
  
  $.get("/todos.json")
    .done(function (todos) {
      console.log("All Todos:", todos);

      // append each todo
      todos.forEach(function (todo) {
        $todosCon.append("<div>" +  todo.content + "</div>");
      });

  });

  var $todoForm = $("#new_todo")

  $todoForm.on("submit", function (event) { 
    event.preventDefault();
    console.log("Form submitted", $(this).serialize());

    var content = $("#todo_content").val();
    $.post("/todos.json", {
      todo: {
        content: content
      }
    }).done(function (createdTodo) {
      $todosCon.append("<div>" + createdTodo.content + "</div>")
    });
  });

});

```


### Saving Data

Let's setup our controller to save the information, and send it back.

```ruby

  def create

    @todo = Todo.create(params.require(:todo).permit(:content))

    respond_to do |f| 
      f.html
      f.json { render json: @todo }
    end

  end

```

## Part 2: Deleting and Editing

In order to setup a delete we need to add `delete` buttons to all our elements, and the listen for clicks from any of those buttons.


Let's update our `append` to have a button.

`app/assets/javascripts/application.js`
```js

$todoForm.on("submit", function (event) { 
  event.preventDefault();
  console.log("Form submitted", $(this).serialize());

  var content = $("#todo_content").val();
  $.post("/todos.json", {
    todo: {
      content: content
    }
  }).done(function (createdTodo) {
    $todosCon.append("<div>" + 
                    createdTodo.content + 
                    "<button class=\"delete\">Delete</button></div>")
  });
});


```

**NOTE**: this only updated the `append` for the `formSubmit`, so unless you want only new todos to have a delete button, we should update all the `append` methods.

`app/assets/javascripts/application.js`
```js
  $todosCon.append("<div>" + 
                    createdTodo.content + 
                    "<button class=\"delete\">Delete</button></div>")
```

Be sure to update the `append` in `$.get("/todos.json")`

`app/assets/javascripts/application.js`
```js
  $todosCon.append("<div>" + 
                    todo.content + 
                    "<button class=\"delete\">Delete</button></div>")
```



Let't also listen for `click`'s on any of those `delete` buttons.

`app/assets/javascripts/application.js`
```js
  // setup a click handler that only
  //  handle clicks from an element
  //  with the `.delete` className
  //  that is inside the $todosCon
  $todosCon.on("click", ".delete", function (event) {
    alert("I was clicked!");
  });

```

This is kind of a new trick for us, and it's called **event delegation**. We are watching the `$todosCon` for someone clicking on something inside that matches the `selector` we passed in.


All together we have:

`app/assets/javascripts/application.js`
```js


// wait for window load
$(function () {
  
  // grab the `todos-con`
  var $todosCon = $("#todos-con");
  
  $.get("/todos.json")
    .done(function (todos) {
      console.log("All Todos:", todos);

      // append each todo
      todos.forEach(function (todo) {
        $todosCon.append("<div>" + 
                        todo.content + 
                        "<button class=\"delete\">Delete</button></div>");
      });

  });

  var $todoForm = $("#new_todo")
  $todoForm.on("submit", function (event) { 
    event.preventDefault();
    console.log("Form submitted", $(this).serialize());

    var content = $("#todo_content").val();
    $.post("/todos", {
      todo: {
        content: content
      }
    }).done(function (createdTodo) {
      $todosCon.append("<div>" + 
                      createdTodo.content + 
                      "<button class=\"delete\">Delete</button></div>")
    });
  });

  // setup a click handler that only
  //  handle clicks from an element
  //  with the `.delete` className
  //  that is inside the $todosCon
  $todosCon.on("click", ".delete", function (event) {
    alert("I was clicked!");
  });


});


```


Next we need to send an actual `DELETE` request to the server, which might look something like this.

`app/assets/javascripts/application.js`
```js

    $.ajax({
      url: "/todos/:some_id.json",
      type: "DELETE"
    }).done(function () {
      alert("DELETED!")
    });


```

However, how are we going to get the `id` of the object that we want to delete from the server? We could use a simple trick to just add the `id` to an attribute on the element we want to `delete`. Let's update our `append` to do that. While we are at it let's also give each todo a `class` of `.todo`

`app/assets/javascripts/application.js`
```js
    $todosCon.append("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                    createdTodo.content + 
                    "<button class=\"delete\">Delete</button></div>");

```

**NOTE**: this only updated the `append` for the `formSubmit`, so also update the `$.get` as well.

`app/assets/javascripts/application.js`
```js
    $todosCon.append("<div class=\"todo\" data-id=" + todo.id + ">" + 
                    todo.content + 
                    "<button class=\"delete\">Delete</button></div>");

```



Now we can grab that from our view. Only there's one problem. When someone clicks the `delete` button that's all we have access to, but we want to find containing `div`'s `data-id` attribute. In jQuery we can use `.closest` to find that parent `div`.

`app/assets/javascripts/application.js`
```js
  // setup a click handler that only
  //  handle clicks from an element
  //  with the `.delete` className
  //  that is inside the $todosCon
  $todosCon.on("click", ".delete", function (event) {
    alert("I was clicked!");

    // grab the entire todo
    var $todo = $(this).closest(".todo");

    // send our delete request
    $.ajax({
      // grab the data-id attribute
      url: "/todos/" + $todo.data("id") + ".json",
      type: "DELETE"
    }).done(function (){
      // once we completed the delete
      $todo.remove();
    })
  });


```

All together we have




`app/assets/javascripts/application.js`
```js


// wait for window load
$(function () {
  
  // grab the `todos-con`
  var $todosCon = $("#todos-con");
  
  $.get("/todos.json")
    .done(function (todos) {
      console.log("All Todos:", todos);

      // append each todo
      todos.forEach(function (todo) {
        $todosCon.append("<div class=\"todo\" data-id=" + todo.id + ">" + 
                      todo.content + 
                      "<button class=\"delete\">Delete</button></div>");
      });

  });

  var $todoForm = $("#new_todo")
  $todoForm.on("submit", function (event) { 
    event.preventDefault();
    console.log("Form submitted", $(this).serialize());

    var content = $("#todo_content").val();
    $.post("/todos.json", {
      todo: {
        content: content
      }
    }).done(function (createdTodo) {
      $todosCon.append("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                      createdTodo.content + 
                      "<button class=\"delete\">Delete</button></div>");
    });
  });

  // setup a click handler that only
  //  handle clicks from an element
  //  with the `.delete` className
  //  that is inside the $todosCon
  $todosCon.on("click", ".delete", function (event) {
    alert("I was clicked!");

    // grab the entire todo
    var $todo = $(this).closest(".todo");

    // send our delete request
    $.ajax({
      // grab the data-id attribute
      url: "/todos/" + $todo.data("id") + ".json",
      type: "DELETE"
    }).done(function (){
      // once we completed the delete
      $todo.remove();
    })
  });

});

```

This assumes on the backend we have an `destroy` method

```ruby
  def destroy
    # find the `todo`
    # delete the `todo`
  end

```

* To **find** the todo we just say `Todo.find(params[:id])`
* To **delete** a todo we just say `todo.destroy()`


```ruby

  def destroy
    # find the `todo`
    todo = Todo.find(params[:id])
    # delete the `todo`
    todo.destroy()

    respond_to do |format|
      format.html { redirect_to todos_path }
      format.json { render json: nil, status: 200 }
    end
  end

```


## Updates and Editing


### Checkboxes

**NOTE** Add the update action to your todos controller

```ruby
  def update
    # find the `todo`
    @todo = Todo.find(params[:id])
    # update the todo
    @todo.update_attributes(params.require(:todo).permit(:completed, :content))
    # then respond to format

    respond_to do |format|
      format.html
      format.json { render json: @todo }
    end
  end
```

One of the simplest updates we can do is to add a completed `checkbox`. Let's update our `append` to also have the `checkbox`.

`app/assets/javascripts/application.js`
```js
  $todosCon.append("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                  createdTodo.content + 
                  "<input type=\"checkbox\" class=\"completed\">" +
                  "<button class=\"delete\">Delete</button></div>");

```

**NOTE**: this only updated the `append` for the `formSubmit`, so also update the `$.get` as well.

`app/assets/javascripts/application.js`
```js
  $todosCon.append("<div class=\"todo\" data-id=" + todo.id + ">" + 
                  todo.content + 
                  "<input type=\"checkbox\" class=\"completed\">" +
                  "<button class=\"delete\">Delete</button></div>");

```

Now let's update our code to add a listener to handle when `completed` is clicked.

`app/assets/javascripts/application.js`
```js

$todosCon.on("click", ".completed", function () {
  var $todo = $(this).closest(".todo");

  $.ajax({
    url: "/todos/" + $todo.data("id") + ".json",
    type: "PATCH",
    data: {
      todo: {
        completed: this.checked
      }
    }
  }).done(function (data) {
    // update the styling of our todo
    $todo.toggleClass("todo-completed")
  })
});

```

The above assumes we have some styling for the `.todo-completed` class. 

`app/assets/stylesheets/todos.scss`
```css
 .todo-completed {
    color: gray;
  }

```

All together we have:




`app/assets/javascripts/application.js`
```js


// wait for window load
$(function () {
  
  // grab the `todos-con`
  var $todosCon = $("#todos-con");
  
  $.get("/todos.json")
    .done(function (todos) {
      console.log("All Todos:", todos);

      // append each todo
      todos.forEach(function (todo) {
        $todosCon.append("<div class=\"todo\" data-id=" + todo.id + ">" + 
                        todo.content + 
                        "<input type=\"checkbox\" class=\"completed\">" +
                        "<button class=\"delete\">Delete</button></div>");
      });

  });

  var $todoForm = $("#new_todo")
  $todoForm.on("submit", function (event) { 
    event.preventDefault();
    console.log("Form submitted", $(this).serialize());

    var content = $("#todo_content").val();
    $.post("/todos.json", {
      todo: {
        content: content
      }
    }).done(function (createdTodo) {
      $todosCon.append("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                      createdTodo.content + 
                      "<input type=\"checkbox\" class=\"completed\">" +
                      "<button class=\"delete\">Delete</button></div>");
    });
  });

  // setup a click handler that only
  //  handle clicks from an element
  //  with the `.delete` className
  //  that is inside the $todosCon
  $todosCon.on("click", ".delete", function (event) {
    alert("I was clicked!");

    // grab the entire todo
    var $todo = $(this).closest(".todo");

    // send our delete request
    $.ajax({
      // grab the data-id attribute
      url: "/todos/" + $todo.data("id") + ".json",
      type: "DELETE"
    }).done(function (){
      // once we completed the delete
      $todo.remove();
    })
  });

  $todosCon.on("click", ".completed", function () {

    var $todo = $(this).closest(".todo");

    $.ajax({
      url: "/todos/" + $todo.data("id") + ".json",
      type: "PATCH",
      data: {
        todo: {
          completed: this.checked
        }
      }
    }).done(function (data) {
      // update the styling of our todo
      $todo.toggleClass("todo-complete")
    })
  });

});

```

### A Better Checkbox

Theres' only one problem with our checkboxes right now, and it's that they use the `todo.completed` to display a check or no check. They are updating the server.


If we separate out the `append` text for our todo so that we can add some styling and manipulate them then it should make our rendering lives easier. This will also make our code more readable.

`app/assets/javascripts/application.js`
```js
  var $todo = $("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                      createdTodo.content + 
                      "<input type=\"checkbox\" class=\"completed\">" +
                      "<button class=\"delete\">Delete</button></div>");


  $todosCon.append($todo);             
```

**NOTE**: this only updated the `append` for the `formSubmit`, so also update the `$.get` as well.

`app/assets/javascripts/application.js`
```js
  var $todo = $("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                      createdTodo.content + 
                      "<input type=\"checkbox\" class=\"completed\">" +
                      "<button class=\"delete\">Delete</button></div>");


  $todosCon.append($todo);             
```


Now we can use the `$todo` to update the `checkbox` before we append it to the page.

`app/assets/javascripts/application.js`
```js
  var $todo = $("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                      createdTodo.content + 
                      "<input type=\"checkbox\" class=\"completed\">" +
                      "<button class=\"delete\">Delete</button></div>");

  $todo.find(".completed").attr("checked", createdTodo.completed)
  $todosCon.append($todo);             
```

**NOTE**: this only updated the `append` for the `formSubmit`, so also update the `$.get` as well.

`app/assets/javascripts/application.js`
```js
  var $todo = $("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                      createdTodo.content + 
                      "<input type=\"checkbox\" class=\"completed\">" +
                      "<button class=\"delete\">Delete</button></div>");

  $todo.find(".completed").attr("checked", createdTodo.completed);

  $todosCon.append($todo);             
```

The only difference here is that we need to make sure that for our `$.get` we append a `todo` with the `.todo-completed` styling.

`app/assets/javascripts/application.js`
```js
  var $todo = $("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                      createdTodo.content + 
                      "<input type=\"checkbox\" class=\"completed\">" +
                      "<button class=\"delete\">Delete</button></div>");

  $todo.find(".completed").attr("checked", createdTodo.completed);

  if (createdTodo.completed) {
    $todo.toggleClass("todo-completed")
  }

  $todosCon.append($todo);             
```


All together we now have

`app/assets/javascripts/application.js`
```js


$(function () {

  // grab the `todos-con`
  var $todosCon = $("#todos-con");

  $.get("/todos.json")
    .done(function (todos) {
      console.log("All Todos:", todos);

      // append each todo
      todos.forEach(function (todo) {
      	var completed = todo.completed ? "todo-completed" : "";
      	var checked = todo.completed ? "checked" : "";
        $todosCon.append("<div class=\"todo "+ completed + "\" data-id=" + todo.id + ">" + 
                        todo.content + 
                        "<input type=\"checkbox\" class=\"completed\" " + checked + ">" +
                        "<button class=\"delete\">Delete</button></div>");
      });

  });

  var $todoForm = $("#new_todo")
  $todoForm.on("submit", function (event) { 
    event.preventDefault();
    console.log("Form submitted", $(this).serialize());

    var content = $("#todo_content").val();
    $.post("/todos.json", {
      todo: {
        content: content
      }
    }).done(function (createdTodo) {
      var $todo = $("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                    createdTodo.content + 
                    "<input type=\"checkbox\" class=\"completed\">" +
                    "<button class=\"delete\">Delete</button></div>");

      $todo.find(".completed").attr("checked", createdTodo.completed);

      if (createdTodo.completed) {
        $todo.toggleClass("todo-complete")
      }

      $todosCon.append($todo);  
    });
  });

  // setup a click handler that only
  //  handle clicks from an element
  //  with the `.delete` className
  //  that is inside the $todosCon
  $todosCon.on("click", ".delete", function (event) {
    alert("I was clicked!");

    // grab the entire todo
    var $todo = $(this).closest(".todo");

    // send our delete request
    $.ajax({
      // grab the data-id attribute
      url: "/todos/" + $todo.data("id") + ".json",
      type: "DELETE"
    }).done(function (){
      // once we completed the delete
      $todo.remove();
    })
  });

  $todosCon.on("click", ".completed", function () {

    var $todo = $(this).closest(".todo");

    $.ajax({
      url: "/todos/" + $todo.data("id") + ".json",
      type: "PUT",
      data: {
        todo: {
          completed: this.checked
        }
      }
    }).done(function (data) {
      // update the styling of our todo
      $todo.toggleClass("todo-complete")
    })
  });

});

```

**Bonus:** What bugs does this final code have? Fix them.


## `.done(function (lesson) { lesson.end() })`
