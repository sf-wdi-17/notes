## Prototype Exercises

* Make a `Starship` constructor that takes a `model` and `ownerName`. 
  * Give your `StarShip` a `setTopSpeed` method and a `getTopSpeedMethod` that let you change and read the `topSpeed`. *Assume `topSpeed` is just a number.*
  * Give your `Starship` an `accelerateTo` method that sets `currentSpeed` to some number, unless that number is greater than its `topSpeed`.
* Make a `Dice` constructor that takes a `numberOfSides`. Add a method called `getSide` or `roll` that randomly returns a number from `1` up to the `numberOfSides`.
  * Modify your `getSide` method to record the returned side in a `lastRoll` property.
* Make a `Radio` constructor that takes in an `ownerName` and a `signalType` ("AM" or "FM"). 
  * Add a `setStation` method to your radio that allows the following ranges:
    * `535` to `1705` for "AM".
    * `88` to `108` for "FM".
  * Add a `listen` method that returns the following:
    * `"distorted music"` for "AM".
    * `"clear music"` for "FM".
* Make a `Mailer` constructor that takes a `from` email address, and has `currentMessage` set to an empty object, as well as a `sentMessages` array.
  * Add a `setSendTo` method that sets `currentMessage.sendTo` to be a specified email.
  * Add a `setSubject` method that sets `currentMessage.subject` to be a specified subject.
  * Add a `send` method that sets `currentMessage.from` to be `this.from`, pushes `currentMessage` into `sentMessages`, and sets `currentMessage` to be a new object.
    * Modify `send` so that it checks if `currentMessage` has both a `sendTo` and `subject` before pushing to `sentMessages`.
