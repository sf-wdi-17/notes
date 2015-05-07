## WDI SECOND PROJECT DESCRIPTION
For the second project you will use your knowledge of front and back-end web development to produce an awesome web application that can be used by friends, family or others online. The type of web application you create is your choice: utilities, social networks, games, mashups, etc. Ensure however that the scope of your project is not too large so that you can reasonably complete a [MVP](http://en.wikipedia.org/wiki/Minimum_viable_product) in this time. 

The objective of this project is to:

* Get experience collaborating and working in a development team.
* To gain experience integrating topics covered during this course thus far.
* Showcase your abilities to potential employers, friends, family, and community members.

You will be working in **groups of 3-4** for this project. 

We highly recommend you designate one member of the group to be the "project manager". This team member will facilitate the division of responsibilities and analyze progress to make sure your project stays on track and on schedule.

You should also be designating another member of your team as your Git Manager. This person will be responsible for merging each team member's work into your master branch (your production branch) once that work has been tested and deemed ready for release.

## CORE REQUIREMENTS
* **Models.** Your app should have at least 3 models with appropriate associations and validations.
* **Views.** [Use **partials**](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials) heavily to DRY (Don’t Repeat Yourself) up your views, and load data via AJAX whenever appropriate.
* **RSPEC** All of your [models must have specs](https://www.relishapp.com/rspec/rspec-rails/v/2-3/docs/model-specs) (and while not required, [some request specs](https://www.relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec) should be written as well). Less than 10 specs total will reflect very negatively on the overall assessment. Write them early on or you will be struggling to get them done. 
* **Postgres.** Use [PostgreSQL](http://www.postgresql.org/) as your database in both development and production environments.
* **Handles invalid data.** Forms in your application should validate data and handle incorrect inputs. You should be doing this both on the client-side with JavaScript and on the back-end (AKA server-side) with Rails.
* **JavaScript & jQuery.** Spice up the front-end of your app and have some event driven functionality. (Maybe research, and then try out a new plugin or a library.)
* **AJAX.** Use [AJAX](http://api.jquery.com/category/ajax/) to communicate with the server without reloading the page whenever appropriate.
* **External APIs.** Use at least one external API to add functionality to your app (you may use multiple APIs if your MVP requires this.)
* **User Login.** Make sure you have authentication and authorization set up.
    - *BONUS: Try to add password reset functionality!*
* **Home and About pages** - Don't forget to work on a proper homepage. 
    - A "proper" home page will clearly explain what your app is and what it does. 
    - If you feel like showing off, create an "About" page too (with some photos, maybe?)
* **Heroku.** [Deploy your code to Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails4#deploy-your-application-to-heroku).
    - Additional instructions are available in our repo in the "resources" folder.
* **User Experience** Ensure a pleasing and logical user experience. We suggest you use a front-end CSS framework like Bootstrap to enhance your CSS styling.


## OTHER IDEAS
While some of these topics were not covered in great detail in class, if you want to push yourself and learn something new, optionally consider doing some of the following with your app.

* **[Responsive Design](http://en.wikipedia.org/wiki/Responsive_web_design)** Make sure your app looks decent on a phone or tablet.
* **File upload** Take a look at [Paperclip](https://github.com/thoughtbot/paperclip) or [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) using [Amazon S3](http://aws.amazon.com/s3/) for file hosting.
* **Web Scraping** Use [Nokogiri](http://nokogiri.org/), [mechanize](https://github.com/sparklemotion/mechanize), and [phantom.js](http://phantomjs.org/).
* **Regex** You might consider using Regular Expressions to process text. Validation is one common use case. Use [Rubular](http://rubular.com/) for initial testing.
* **Charting** Visualize your data with [Morris.js](http://www.oesmith.co.uk/morris.js/) or [D3](http://d3js.org/).
* **Job Scheduling** Fnid a way to include Sidekiq (or Delayed Job or Resque) to your project.

## PLANNING & DELIVERABLES


####Project Plan deliverables:
*You should review the following with your instructional team BEFORE you start to code.*

* **Group members.** You'll be working in groups of 3 or 4. Everyone has different strengths. It may be beneficial to figure out what those are within your group and assign tasks accordingly.
* **Scope.** What are you planning to build? What do you reasonably think you can implement in the time period? It's great to have big ideas for features, but be sure you also have a well-scoped MVP that can be accomplished during the next week.
* **User stories.** What features will your app have? Set up your project and [user stories](http://www.romanpichler.com/blog/10-tips-writing-good-user-stories/) in [Trello](https://trello.com).
* **Wireframes.** Sketch out what your pages (AKA views) will look like and how they will work. Paper works great. You can also check out wireframing software like Gliffy or Omnigraffle.
    - Want more info on Wireframing? [Check out this resource we put together...](../reading/resources/wireframing.md)
* **Object Models.** Draw out the model associations for your project.
    - Try using [Class Diagrams and/or Entity-Relationship Diagrams](http://www.cs.toronto.edu/~sme/CSC340F/2005/slides/tutorial-classes_ERDs.pdf) to do this!
* **Milestones.** Outline some milestones for your team (and each member) based on your preferred working styke.


####Completed Project deliverables:

* Link to Heroku hosted project
* Link to source code on GitHub
  * Must include a `README.md` with the following:
    * `Description`: A short elevator pitch for your project
    * A link to the hosted version of your project on Heroku.
    * `Wireframes`
      * This is a good opportunity to map out what will require AJAX 
    * `User Stories`, `Site Flow`, or equivalent for MVP
    * An **ERD** or **Class Diagram** that describes your data layer (models).
    * API's used
    * Project scope
    * Wishlist (what you'd like to work on/finish later)
    * Contributors

## TIMELINE

* May 7 - Thursday - Project specs released (groups were assigned on May 4th)
* May 10th, 6PM - Deadline for delivery of Project Plan
* May 11th, 9AM - All projects approved (hopefully)
* May 15 - Friday - Completed project deliverables due at 10am