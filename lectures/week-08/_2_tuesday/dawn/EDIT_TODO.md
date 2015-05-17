
## Editing A Todo

Let's try to edit a `todo`. Let's first make a `form` that we can append to the page.


```

$(function () {

  // we define this variable at
  //  the top of our on-load function
  
  var $editForm = $("<form>" +
                    "<input type=\"text\" id="edit_todo_content"> +
                    "<button>Update</button>" +
                  "</form>");

  ...

})

```


Let's update our `append` function from earlier to have an `edit` button.


```
$todosCon.append("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                createdTodo.content + 
                "<button class=\"edit\">Edit</button>" + 
                "<button class=\"delete\">Delete</button></div>");

```



Now let's listen for a `click` on the `edit` button.



```

$todosCon.on("click", ".edit", function () {
  var $todo = $(this).closest(".todo")
  alert("Editing");
});

```


However, we are going to need to want to hide our `$todo` content when we are editing so we should update our `append` to do this easily.


```
$todosCon.append("<div class=\"todo\" data-id=" + createdTodo.id + ">" + 
                  "<div class=\"todo-info\">" +
                    "</div class="\todo-content\">" +
                      createdTodo.content + 
                    "</div>" +
                    "<button class=\"edit\">Edit</button>" + 
                    "<button class=\"delete\">Delete</button>"  +
                  "</div>" +
                "</div>");

```


Now we can hide the `$todo` when `edit` is clicked.


```

$todosCon.on("click", ".edit", function () {

  var $todo = $(this).closest(".todo");
  alert("Editing");

  var $todoInfo = $todo.find(".todo-info");
  $todoInfo.toggle();

});

```

That's helpful so someone can't click edit on elements twice. Now let's add the $editForm


```

$todosCon.on("click", ".edit", function () {

  var $todo = $(this).closest(".todo");
  alert("Editing");

  var $todoInfo = $todo.find(".todo-info");
  $todoInfo.toggle();

  $todo.append($editForm);

});

```


Note how now the edit form shows up, but what happens if someone submits it?

*NOTHING!*


Let's change that.




```

$todosCon.on("click", ".edit", function () {

  var $todo = $(this).closest(".todo");
  alert("Editing");

  var $todoInfo = $todo.find(".todo-info");
  $todoInfo.toggle();
  var todoContent = $todo.find(".todo-content").val();

  $editForm.attr("action", "/todos/"+ $todo.data("id"))
  $editForm.find("#edit_todo_content").val(todoContent);

  $todo.append($editForm);



});

```

However, when we submit the form it needs a handler `preventDefualt` and send an `ajax` request.


```

  $editForm.on("submit", function (event) {
    event.preventDefault();

    $.ajax({
        url: $editForm.attr("action"),
        method: "PATCH"
      }).done(function (data) {
          // we need to redisplay
          // the todo... hmmm?
      });
  });

```

### On The Backend 

We should add a standard `todos#update` method to our controller.
