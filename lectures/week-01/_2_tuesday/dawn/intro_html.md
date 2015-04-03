## HTML

### What is this <!DOCTYPE html>?

Always, always make sure to put this at the top of your HTML file, otherwise you will enter quirks mode, which is no fun for anyone - read more about quirks mode here [http://en.wikipedia.org/wiki/Quirks_mode](http://en.wikipedia.org/wiki/Quirks_mode) and read a very good Stack Overflow answer as to why you need a Doctype [here](http://stackoverflow.com/questions/6076432/why-do-i-need-a-doctype-what-does-it-do)

### Meta Tags

Metadata is data (information) about data. The <meta> tag provides metadata about the HTML document. Metadata will not be displayed on the page, but will be machine parsable. Meta elements are typically used to specify page description, keywords, author of the document, last modified, and other metadata. The metadata can be used by browsers (how to display content or reload the page), search engines (keywords), or other web services.

Some common meta tags you will see are charset, content, author, description (for SEO), http-equiv (which we will learn about more when we discuss HTTP Headers)

### Divs + Spans

HTML provides for us two 'empty' containers to store whatever content we want. One is a div (block element) and the other is a span (inline element)

### Forms, Labels, Input Types and HTML5 Attributes

Forms - One of the most common ways to send data to a server is by using a form. A form has two essential attributes, action and method.

* Action - This specifies a route where you are going to. For example an action of '/test' will take you to the /test route (something you have probably configured in your server side code)

* Method - The HTTP Verb that this form will be using (HTML only knows GET and POST, but there are ways to override this default which we will see when we use Node and Rails. The default method is GET so if you are making a GET request you can leave this empty.

Label - Labels are text you place before/after inputs to tell the user what the input is for. The for attribute is for screen readers and if the ID of the input matches the ID of the for attribute then you can click on the label and have it automatically focus/check the input.

HTML5 provides a couple new attributes for inputs which improve user experience. Some of these are:

* autofocus - automatically focuses on an input (don't put this on more than one)
* required - ensures that there is text in the input field you place it before the user submits the form (you can put this on as many inputs as you'd like). If your input type is email or number, the validation will be a bit different.

### Tables

Before CSS became mainstream, websites were designed using tables. Although they are much less frequently used, building tables is still a very useful skill to know. The tags for tables are such:

* `<table></table>` - create a table
* `<tr></tr>` - create a table row
* `<th></th>` - create a table heading
* `<td></td>` - create a table cell
* `<tbody></tbody>` - create the body of the table (newer tag)
* `<thead></thead>` - create the head of the table (newer tag). No matter where this is located, whatever is in it will be the first row
* `<tfoot></tfoot>` - create the foot of the table (newer tag). No matter where this is located, whatever is in it will be the last row




