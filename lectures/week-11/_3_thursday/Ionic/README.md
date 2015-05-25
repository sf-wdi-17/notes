#[Ionic](http://ionicframework.com/)
>**A Hybrid Mobile Development Framework based on AngularJS**

![logo](http://ionicframework.com/img/blog/angularjs-ionic-framework.jpg)
###Objective: Manipulate and Emulate an Ionic App
Ionic is a hybrid app development framework. What is "Hybrid"? A hybrid app uses Phonegap to wrap HTLM, JS, and CSS files into a native web view.

![phonegap stack](https://www.ibm.com/developerworks/community/blogs/worklight/resource/BLOGS_UPLOADED_IMAGES/2.BasicCordovaAppViewStack.png)



Why did they build it on Angular? - [Because Angular is the most Popular JS Framework](http://www.google.com/trends/explore?hl=en-US#q=angularjs,+ember.js,+knockoutjs,+backbonejs&cmpt=q)


###Native vs. Hybrid

>**Note**: We will not be building any backend or server, so all data and server-side processes will be 'mocked' or 'stubbed out'.

###Getting Started: Project

##### 1. Write User Narratives
"I'm Conny the Coder and I use user narratives to guide my work, write tests, build views, and pick good variable, function, and model names."
##### 2. Make Wireframes

##### 3. Pick tools

We're gonna use Ionic! Why? Can you name 3 reasons? When would you use native? 

##### 3. Make a Step-by-Step Plan (in English)

1. Bootstrap Ionic Project
2. What is your basic navigation? Tabs? Sidemenu? Neither?
3. 


###Getting Started: Ionic

#####1. Install Ionic and cordova with NPM 

```$ npm sudo install -g cordova ionic```

#####2. Then initialize a 'tabs' seed ionic project

```$ ionic start workshop sidemenu```

#####3. lurk around in the code. What do you see?

```
<!-- File structure -->

|hooks
|plugins
|scss
|www <!-- Your Angular App Lives Here -->
.bowerrc
.gitignore
bower.json <!-- For Adding Client-side JS Packages -->
config.xml
gulpfile.js
ionic.project
package.json <!-- For Adding Development Environment and Device Packages -->
```
##### 4. Set Browser to Emulation Mode or Emulate in Virtual Device
```
$ cd workshop
$ ionic serve
Chrome > Developer tools > Console > Emulation > Device: iPhone 6
```
or try emulating an iOS device (might require XCode)
```
$ cd workshop
$ ionic platform add ios
$ ionic build ios
$ ionic emulate ios
```

### Project
##### 3. 