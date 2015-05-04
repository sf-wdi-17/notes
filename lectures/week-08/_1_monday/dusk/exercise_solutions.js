// READ
$.getJSON('/posts/1', function(data) {
  console.log(data);
});

$.getJSON('/posts', function(data) {
  data.forEach(function(post) {
    console.log(post);
  });
});

// CREATE
var thePost = {
  post: {
          title: "Hellooo",
          content: "Boooooo"
        }
};

$.post('/posts', thePost, function(data) {
  console.log(data);
});

// Delete
var req = {
  url: "/posts/1.json",
  type: "DELETE"
};

$.ajax(req, function(resp) {
 console.log(resp);
});

// UPDATE
var req = {
  url: "/posts/2.json",
  type: "PUT",
  data: {
    post: {
            title: "Boooo",
            content: "LAME"
          }
  }
};

$.ajax(req, function(resp) {
 console.log(resp);
});
