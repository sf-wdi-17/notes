# CSS
Lecture on CSS

# Objective
Students will be able to...

- Write basic CSS expressions
- Add classes and ids to HTML tags
- Improve their about me pages with styling

# Link
The about me pages we built earlier this week look pretty dull and boring. They need some styling! We can do that with CSS.

# Educate and Engage
"CSS" stands for cascading style sheets. Styles define how to display HTML elements. HTML elements are identified either by `tag`, `id` or `class`.

Example:

```html
<a href="" id="pretty-link" class="awesome-links"></a>
```

Things to keep in mind with this example:

- The tag is `a`
- The `id` is "pretty-link" and can only be used once per page
- The `class` is "awesome-links" and can be assigned to multiple elements on a page

To apply styling to all anchor tags, you could write the following:

```css
a {
	/* style rules here */
}
```

To apply styling to an `id`, use the `#`-notation:

```css
#pretty-link {
	/* style rules here */
}
```

To apply styling to all elements of a class, use the `.`-notation:

```css
.awesome-links {
	/* style rules here */
}
```

Style rules follow a simple `key: value;` pattern, such as:

```css
a {
	/* This will turn all links red */
	color: red;
}
```

CSS style rules are stored in a `.css` file and required in an HTML head like so:

```html
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" type="text/css" href="path/to/css-file.css">
</head>
<body>
	<!-- Body here... -->
</body>
</html>
```

# Active Learning
Research how to do the following and apply these styles to your elements on your about me page:

- Make your h1 30px big and green
- Make your h2 20px big and green
- Make all your paragraphs dark gray and 15px big
- Make both your images have a border that's 10px wide
- Make your first image have a red border, and your sedond image have a blue border
- Increase the margin between all list items
- Make all links turn red when you hover over them with your mouse
- Center your h1
- Right-align your list of three favorite technologies
- move the width and height attributes from your images into your stylesheet

# Reflect
*Go over assignment with students*

In summary, you learned the following:

- applying styles to one, many, or all instances of a tag
- changing colors
- adding border width and color
- basic positioning
- events like hover

# Now and Then
Although this course doesn't focus on CSS as much as other technologies, you will use CSS throughout your career.

More to read:

- [Positioning](http://www.w3schools.com/css/css_positioning.asp)
- [Layouts](http://www.w3schools.com/html/html_layout.asp)
- [Box model](http://www.w3schools.com/css/css_boxmodel.asp)
