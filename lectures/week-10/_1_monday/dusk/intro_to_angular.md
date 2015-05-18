# Intro To Angular

![](angularjs.jpeg)

## Data-Binding, Templates, and All That


| Objectives  | 
| :----     |
| Student should use data binding in views: `ng-model`, `ng-bind` |
| Students should be comfortable with commonly used directives: `ng-repeat` with `ng-model` or `ng-bind`. |
| Students should use directives together to create templates   |   

## Outline

* What is Angular?* 
  - AngularJS is a client-side Javascript framework for adding interactivity to HTML. It lets you use HTML as your template language and lets you extend HTML's syntax to express your application's components clearly and succinctly.
 
* [Sites that use `Angular'](https://builtwith.angularjs.org/)

- Let's take a step back:

  - HTML is a great declarative language for static documents. It does not contain much in the way of creating applications, and as a result building web applications is an exercise in what do I have to do to trick the browser into doing what I want?

* Why `Angular`? How is it different?
  -  It attempts to minimize the impedance mismatch between document centric HTML and what an application needs by creating new HTML constructs.
  
  - Angular implements MVC by asking you to split your app into MVC components, then just let Angular do the rest. Angular manages your components for you and also serves as the pipeline that connects them.


###Getting Started
  * Visit [angularjs.org](Angular) and download Angular.
  
  ####What is a Directive?
  
  * In Angular, we add behavior to our HTML through directives. A directive is a marker on a HTML tag that tells Angular to run or reference some Javascript code.
  
  * The `ngApp` directive -  denotes the beginning of an application, and everything inside its tags will have access to binding. It attaches the Application Module to the page.


###Data Binding

####Data Binding in Classical Template Systems
  Most templating systems bind data in only one direction: they merge template and model components together into a view. After the merge occurs, changes to the model or related sections of the view are NOT automatically reflected in the view. Worse, any changes that the user makes to the view are not reflected in the model. This means that the developer has to write code that constantly syncs the view with the model and the model with the view.

#####One Way Data Binding
![One Way Data Binding](oneway.png)


####Data Binding in Angular Templates

Angular templates work differently. First the template (which is the uncompiled HTML along with any additional markup or directives) is compiled on the browser. The compilation step produces a live view. Any changes to the view are immediately reflected in the model, and any changes in the model are propagated to the view. The model is the single-source-of-truth for the application state, greatly simplifying the programming model for the developer. You can think of the view as simply an instant projection of your model.

Because the view is just a projection of the model, the controller is completely separated from the view and unaware of it. This makes testing a snap because it is easy to test your controller in isolation without the view and the related DOM/browser dependency.

#####Two-Way Data Binding
![Two-Way Data Binding](twoway.png)



###Other Built-In Directives:
 
  * `ngBind` - this attribute tells Angular to replace the text content of the specified HTML element with the value of a given expression, and to update the text content when the value of that expression changes.
  
* Using the `{{}}` in angular templating can leave a bunch of `{{}}` curly braces on our screen, so we can also use `ng-bind`
  
  ```
  <div ng-app>
    1 + 2 = <span ng-bind="1+2"></span>
  </div>
    
  ```

* Use `ng-bind` to set variables
  
  ```
  <div ng-app>
    1 + 2 = <span ng-bind="answer =3"></span> <br>
    and we can use the answer somewhere else, divide {{answer}} by 2
    
  </div>
    ```
      
####Exercise:

      1. Set a `greeting` to a variable using `ng-bind` and display it.
    2. Try to set a `name` and `salutation` in the same `ng-bind` statement. Display them in the html. What is problematic about doing this?  *(Hint: use `;` to separate the declaractions)* 
    3. Set a few different variables in a single `ng-bind` what determines what gets displayed?
    4. How could we get around the problem of an `ng-bind` always displaying something?
    
###More Directives

  * `ngStyle` - directive allows you to set CSS style on an HTML element conditionally.
  
  ````
  <div ng-app>
    <span ng-bind="person={name:'john', lastname: 'doe'};nill;"></span>
    {{person.name}}
  </div>
  ````

  ````
  <div ng-app>
      <span ng-bind="myStyle={color:'red'};nill;"></span>
      The following text is <span ng-Style="myStyle">important</div>
  </div>
  ````
  
  * `ng-repeat` - directive instantiates a template once per item from a collection. Each template instance gets its own scope, where the given loop variable is set to the current collection item, and $index is set to the item index or key.
  
    ````        
  <div ng-app>
        <div  ng-init="friends=['larry', 'moe', 'curly']">
      <div  ng-repeat="friend in friends">
        {{friend}}
      </div>
      </div>
  </div>
  ````
  
  * `ngInit`- directive allows you to evaluate an expression in the current scope
  
  
###Exercise
 
- Make an array of friends that are objects where each has a `name` and `style` attribute,  
  e.g. `friends=[{name: 'moe', style: {color: blue}}]`, and repeat over them, displaying their style also.  


###Angular Forms

   * `ngModel` - directive binds an input,select, textarea (or custom form control) to a property on the scope using NgModelController, which is created and exposed by this directive.

  * `ngModel` is responsible for:

    1) Binding the view into the model, which other directives such as input, textarea or select require.
    
    2) Providing validation behavior (i.e. required, number, email, url).
    
    3) Setting related css classes on the element (ng-valid, ng-invalid, ng-dirty, ng-pristine) including animations.
     
     Example 1:
     
     ```
   	<div ng-app>
   		
   		<form>
   			<input type="text" ng-model="favoriteColor">
    	</form>
   		
   		Your favorite color is  {{favoriteColor}}
   	</div>
     ```
     
     Example 2:
     
     ```
   		<form>
   			<input type="text" ng-model="favoriteColor">
   			<input type="checkbox" ng-model="showTemplate">
    	</form>
   		<div ng-show="showTemplate">
   		Your favorite color is  <span ng-style="{color: favoriteColor}">blah</span>
   		</div>
     ```
     
    ### Exercise
    
    1.) Use `ng-style` and `ng-model` in a form to create a selector that let's you select from  options for the background colors. *(Hint: Use the `backgroundColor` key instead of `background-color`)*
    
    2.) Go to Google fonts and pick out three favorite fonts and drop them into your `head`, then use the `ng-style` and `ng-model` directives to change the text color and font.
     
     
   * `ngList` - Text input that converts between a delimited string and an array of strings. The delimiter can be a fixed string (by default a comma) or a regular expression.
     * 
     
     ````
 	   <form>
	     <input type="text" ng-model="favoriteBooks.names" ng-list> <br>
       Show Result
     	<input type="checkbox" ng-model="showTemplate">
      </form>
      <div ng-show="showTemplate">
  		  <div ng-repeat="name in favoriteBooks.names">
	      Why do you like {{name}}?
	      </div>
     </div>
    ````
     	
### Exercises:
     
   1.) Use the `ng-list` and `ng-model` directives with a textarea in a form to list out your favorite movies. Use the `ng-repeat` directive to iterate over the array of `favoriteMovies`.
   
  2.) Use `ng-style` and a form inside the `ng-repeat` from exercise `1` that allows you to change both the background and font color.
  
  3.) Add a form outside the `ng-repeat` in exercise `2` that allows you to change the background color of the application.


###Some Cool Features
   * `ng-cloak` - directive is used to prevent the Angular html template from being briefly displayed by the browser in its raw (uncompiled) form while your application is loading.
   * `ng-pluralize` - directive that displays messages according to en-US localization rules
   * `ng-filter` - Selects a subset of items from array and returns it as a new array
   
If you're really into Angular by the end of this, follow [Google's Angular Blog](http://blog.angularjs.org/)!
