# Angular E2E Testing: Protractor (Selenium, WebDriverJS, & Jasmine)
```
Objective: Be able to design and deploy robust E2E/integration/UI tests for an AngularJS project using the Protractor framework
```
####Don't be this guy!
![alt tag](http://blogs.msdn.com/cfs-filesystemfile.ashx/__key/communityserver-blogs-components-weblogfiles/00-00-01-32-02-metablogapi/8054.image_5F00_thumb_5F00_35C6E986.png)

## Part 1: Testing the Client 30 min

#### Example - QuestionQueue.herokuapp.com

#### Browser vs. Server Testing

Testing code that lives on your server can use server-side testing frameworks. **Quick Review: What are some of the testing frameworks for a javascript server?**

But if our client is written AngularJS is written in Javascript, but it lives and works on the client, so how do we test it? 

#### Unit Tests vs. E2E/Integration/UI Tests

To test only one model method or controller method or module method while ignoring, "stubbing" or "mocking" the rest of your application is called "unit testing." 

**Integration **, **UI**, **E2E** (**end-to-end**) are tests that automate a sort of virtual user's interaction with your app. An integration test tests the full functioning of both the server and the client through one workflow, hence they are called "End to End" or "integration" or "UI" tests. Since they test a lot of code, E2E tests are more efficient, but also less precise and if you are not careful more 'brittle'. 

At the very minimum, it is good practice to have a few simple integration tests across the core features of your app as a safety net. Generally every project should have some integration tests, and the larger a project, the more unit tests.

**Rules of thumb: Keep integration tests broad and shallow with good selectors. Keep unit tests laser-focused with good mocks and stubs.**

#### How to design integration tests

**Start with your user narratives**. Even a non-technical person can design integration tests using the "Given-When-Then" model. 

**Activity: Translate one of your user narratives from last week's projects into integration tests using the Given-When-Then model. How many tests did one narrative break down into? 1? more?**

* What's an example of a unit test?
* What's an example of an integrated test?
* Can you think of an example of when something is breaking but an integrated test could still work? Or an integrated test failing when the app actually is working?

## Part 2: Intro to Protractor - Selenium & Jasmine - 10 min

To do unit testing on AngularJS use [Karma](http://karma-runner.github.io/0.12/intro/how-it-works.html). To do E2E tests on AngularJS, the AngularJS team recommends [Protractor](https://angular.github.io/protractor). So we're gonna learn it!

![alt tag](https://angular.github.io/protractor/img/protractor-logo-300.png)

Protractor is the AngularJS-specific glue that connects [WebdriverJS](https://code.google.com/p/selenium/wiki/WebDriverJs) - agnositic javascript bindings for  [Selenium](http://en.wikipedia.org/wiki/Selenium_%28software%29) that commands your browser, and [Jasmine.js](http://jasmine.github.io/) which affords some nice behavior-driven test sugar.

![alt tag](http://engineering.wingify.com/images/2015/02/2.png)

Protractor glues all these together into a cohesive AngularJS-specific Integration or E2E testing environment while giving us some nice abstraction and **AngularJS-specific sugar and selectors.**

## Part 3: Protractor Setup - 30 min

Run through [the Protractor Tutorial](https://angular.github.io/protractor/#/tutorial) from end to end. 30 min.

## Part 4: Avoid 'Brittle' Integration Tests - 5 min

'Brittle' or 'Smelly' tests means bad ones that don't do their jobs efficiently. A brittle test is one that:

1. passes no matter what
2. breaks when the app works
3. tests multiple things
4. tests something irrelevant

Here are three strategies to avoid brittle tests:

1. Use Strong Selectors - Angular models > CSS Selectors
2. Don't try to do too much in one integration test
3. Watch out for asyncronus stuff and don't use hard-coded setTimeout() delays instead detect when loading is complete, promises resolve, or callbacks are called. (Protractor covers this for you quite nicely!)

## Part 5: TDD - Smoke Test - 30 min 

Create a test that opens your angular project and tests that the title is correct. See the Basic Example Solution app if you get stuck.

#### Hints
* You will need to setup a configuration file and your first "spec.js" file
* You will use the getTitle() function on protractor element
* You can run your tests with the command
```
protractor test/<<your_configuration_file.js>>
```

### Part 6: Challenge Questions

* Do you need a server running to run Protractor tests?
* Could you use Protractor to test React.js a competitor client MVC framework to AngularJS?
* If you have a server running, will protractor tests test that everything is working on the server too?
* What is the biggest reason that UI/E2E/Integration Tests become 'brittle'
* Define 'brittle'
* What is the first thing you should do when you write a test?
* What constituent parts does Protract 'glue together'? Could you use those parts individually? When? Under what circumstances?

