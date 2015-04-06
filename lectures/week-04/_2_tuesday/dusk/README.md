# Authorization
Lesson on authorization.

## Learning Objectives
Students will be able to...

- Define authorization
- Understand the objectives of authorization
- Differentiate authentication vs authorization
- Implement authorization by using conditionals

## Definition of Authorization
From [The Open Web Application Security Project](https://www.owasp.org/index.php/Guide_to_Authorization):

"Authorization ensures that the authenticated user has the appropriate privileges to access resources. The resources a user has access to depend on his/her role."

## Objectives of Authorization
Authorization is used to...

- ensure only authorized users can perform allowed actions within their **privilege level**
- control access to protected resources using decisions based upon **role** or **privilege level**
- prevent privilege escalation attacks, for example using administration functions whilst only an anonymous user or even an authenticated user

Following the security principle that the client must not be trusted, authorization must only happen on the server.

## Authorization vs Authentication
The only thing these two terms have in common is that they start with the letters "Auth". Confusing the two is dangerous!

They must work in tandem to provide a sufficient level of security, but here is the distinction:

- Authentication is the process of determining whether someone or something is, in fact, who or what it is declared to be
- Authorization ensures that the authenticated user has the appropriate privileges to access resources

Example: Only the author of a blog post should be able to edit or delete it. An anonymous user, or an authenticated user who is not the author, should not be able to edit or delete it.

Notice that in this example, authorization is based on the authentication state (is the user logged in?), and, if logged in, the user's role. Authorization rules can be inferred from that.

The following pseudo code illustrates potential implementation of this example:

```javascript
// app.js

// Article edit action
app.get('/articles/:id/edit', function(req, res) {
	// Fetch article...
	// Then check if article's author is equal to the current user
	if (currentUser === article.author) {
		res.render('edit', { article: article });
	} else {
		res.send('You are not authorized to do this!');
	}
});

// Article update action
app.patch('/articles/:id', function(req, res) {
	// Fetch article...
	// Then check if article's author is equal to the current user
	if (currentUser ==== article.author) {
		// Update article
	} else {
		res.send('You are not authorized to do this!');
	}
});

// Article destroy action
app.delete('/articles/:id', function(req, res) {
	// Fetch article...
	// Then check if article's author is equal to the current user
	if (currentUser === article.author) {
		// Destroy article
	} else {
		res.send('You are not authorized to do this!');
	}
});
```

## Group Exercise
Let's add authorization to daily planet!

## Now and Then
Authorization and authentication are both indispensable to offer a secure website your users can trust. It is your responsilibity as a web developer to properly implement authorization.
