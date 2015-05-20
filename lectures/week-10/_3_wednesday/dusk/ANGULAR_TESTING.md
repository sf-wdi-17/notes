# Protractor: AngularJS Integration Tests

> Objective: Be able to design and deploy integration tests for an AngularJS project using the Protractor framework

## Unit Tests and Integration Tests - 20 min

#### What is Integration testing?

To test only one model method or controller method or module method while ignoring the rest of your application is called "unit testing." 

**Integration**, **UI**, **E2E** (**end-to-end**) means tests that automate a user's interaction with your app. An integration test tests the full functioning of both the server and the client through one workflow, hence they are called "End to End" or "integration" or "UI" tests. Since they test a lot of code, E2E tests provide more coverage, but as a trade off they are less precise and if you are not careful more 'brittle' - **they can break too easily**. 

At the very minimum, it is good practice to have a few simple integration tests across the core features of your app as a safety net. Every project should have integration tests. As a project grows, unit tests become more useful and relevant.

#### How to design integration tests

**Start with your user narratives**. Even a non-technical person can design integration tests using the "Given-When-Then" model. 

> **Given** the scenario (e.g. wants to writes a new post, is on home page, is on new messages page, et)

> **When** the trigger (e.g. clicks on something, submits form, etc)

> **Then** what you expect to happen (e.g. an element changes on the screen, an element is added to or removed from an array, words appear on the screen, etc)

**Activity: Translate one of your user narratives from last week's projects into integration tests using the Given-When-Then model. How many tests did one narrative break down into? 1? more?** 10 min.

* What's an example of a unit test?
* What's an example of an integrated test?
* Can you think of an example of when something is breaking but an integrated test could still work? Or an integrated test failing when the app actually is working?

**Rules of thumb: Keep integration tests broad and shallow with good selectors. Keep unit tests laser-focused with good mocks and stubs.**

## Big Picture - Testing the Client - 10 min

Testing code that lives on your server can use server-side testing frameworks. But if we want to test a client-side framework like AngularJS, how do we test it? 

#### Example - [QuestionQueue.herokuapp.com](http://questionqueue.herokuapp.com)

To do integration tests on AngularJS, the AngularJS team recommends [Protractor](https://angular.github.io/protractor). So we're gonna learn it!

![alt tag](https://angular.github.io/protractor/img/protractor-logo-600.png)

Protractor is the AngularJS-specific glue that connects [WebdriverJS](https://code.google.com/p/selenium/wiki/WebDriverJs) - agnostic javascript bindings for  [Selenium](http://en.wikipedia.org/wiki/Selenium_%28software%29) that commands your browser, and [Jasmine.js](http://jasmine.github.io/) which affords some nice behavior-driven test sugar.

![alt tag](http://engineering.wingify.com/images/2015/02/2.png)

## Protractor Setup - 30 min

Run through [the Protractor Tutorial](https://angular.github.io/protractor/#/tutorial) from end to end.

## Avoid 'Brittle' Integration Tests - 5 min

'Brittle' or 'Smelly' tests means bad ones that don't do their jobs efficiently. A brittle test is one that:

1. passes no matter what
2. breaks when the app works
3. tests multiple things
4. tests something irrelevant

Here are three strategies to avoid brittle tests:

1. Use Strong Selectors - Angular models > CSS Selectors
2. Don't try to do too much in one integration test
3. Watch out for asynchronous stuff and don't use hard-coded setTimeout() delays instead detect when loading is complete, promises resolve, or callbacks are called. (Protractor covers this for you quite nicely!)

## TDD - Smoke Test - 30 min 

Create a test that opens any of the angular projects you've built (or a fresh clone of [angular-basic](https://github.com/ajbraus/angular-basic)) test that the title is correct.

1. Get a project (either one you've worked on or a fresh clone of angular-basic)
2. add a spec.js and a conf.js files
3. grab the ```element``` for title
4. Get the text of the title by calling ```getText()``` on it
5. Check if the value is equal to what you expect.

#### Hints
* You will need to setup a configuration file and your first "spec.js" file
* Remember ```getText()``` returns a promise, so you'll need to call a ```.then(value)``` function on it to access the value
* You can run your tests with the command ```protractor test/conf.js```
* Make sure your server is running and ```webdriver-manager start``` in a tab of your terminal or Selenium won't work

## Challenge Questions

* What are some of the testing frameworks we've used so far? Ruby/Rails? Javascript/node?
* Do you need a server running to run Protractor tests?
* Could you use Protractor to test React.js a competitor client MVC framework to AngularJS?
* If you have a server running, will protractor tests test that everything is working on the server too?
* What is the biggest reason that UI/E2E/Integration Tests become 'brittle'
* Define 'brittle'
* What is the first thing you should do when you write a test?
* What constituent parts does Protract 'glue together'? Could you use those parts individually? When? Under what circumstances?

## Good to Know

* To do unit testing on AngularJS use [Karma](http://karma-runner.github.io/0.12/intro/how-it-works.html).  


