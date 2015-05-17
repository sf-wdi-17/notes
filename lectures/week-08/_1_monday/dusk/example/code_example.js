// Example code for our jQuery XHR Lesson

// var jqxhr = $.ajax("http://www.omdbapi.com/?s=Wedding")
//  .done(function(result) {
//      alert("Success");
//      $("#response1").html(result);
//  });


var url = "http://www.omdbapi.com/?s=Stargate";

$.get(url, function (data) {
    alert("STANDARD CALLBACK");
    console.log(data);
});

// Working with a promise
$.get(url)
.done(function (data, textStatus, jqXHR) {
    console.log(data);
    alert("DONE: The request was a success");
})
.fail(function (data, textStatus, jqXHR) {
    alert("FAIL: The request failed!");
});

// Always and Then process.setMaxListeners(n);

$.get(url)
.always(function (data, textStatus, jqXHR) {
    // Note how we test the value of textStatus to determine 
    // whether the request was successful
    if (textStatus === "success") {
        console.log(data);
        alert("ALWAYS: The request was a success")
    } else {
        alert("ALWAYS: The request failed!");
    };
});

// An example of using .then()
$.get(url)
.then(function(data, textStatus, jqXHR) {
    // The first function is used if the request succeeds
    console.log(data);
    alert("THEN: The request was a success")
}, function(data, textStatus, jqXHR) {
    // This second function is used if the request fails
    alert("THEN: The request failed!");
});

// An additional example snippet to try our in a chrome snippet after the page has loaded

var url = "http://www.omdbapi.com/";
var query = "Stargate";
$.ajax({
    url: url,
    data: {s: query},
    success: function(result) {
        alert("Success");
        $("#response2").html(result.Search);
        var aHtml = [];
        $ul = $("<ul>");
        result.Search.forEach(function(d) {
            aHtml.push($("<li>").html(d.Title));
        });
        $ul.append(aHtml);

//         console.log(jqxhr);
//         console.log(result);
        $("#response2").html($ul);
    },
    dataType: "json",
    type: "GET"
})

// $.get(url + query, function(data) {
//     $("#response2").html(data.Search[0].Title);
// }, "json")

$.get({
    url: "/www.omdbapi.com/?s=Starship",
    success: function(data) {
        alert(data);
    }
})

