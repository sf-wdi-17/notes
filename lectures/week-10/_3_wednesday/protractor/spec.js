// STEP 0
// describe('Protractor Demo App', function() {
//   it('should have a title', function() {
//     browser.get('http://juliemr.github.io/protractor-demo/');

//     expect(browser.getTitle()).toEqual('Super Calculator');
//   });
// });

// STEP 1
// describe('Protractor Demo App', function() {
//   it('should add one and two', function() {
//     browser.get('http://juliemr.github.io/protractor-demo/');
//     element(by.model('first')).sendKeys(1);
//     element(by.model('second')).sendKeys(2);

//     element(by.id('gobutton')).click();

//     expect(element(by.binding('latest')).getText()).
//         toEqual('5'); // This is wrong!
//   });
// });

// STEP 2
// describe('Protractor Demo App', function() {
//   var firstNumber = element(by.model('first'));
//   var secondNumber = element(by.model('second'));
//   var goButton = element(by.id('gobutton'));
//   var latestResult = element(by.binding('latest'));

//   beforeEach(function() {
//     browser.get('http://juliemr.github.io/protractor-demo/');
//   });

//   it('should have a title', function() {
//     expect(browser.getTitle()).toEqual('Super Calculator');
//   });

//   it('should add one and two', function() {
//     firstNumber.sendKeys(1);
//     secondNumber.sendKeys(2);

//     goButton.click();

//     expect(latestResult.getText()).toEqual('3');
//   });

//   it('should add four and six', function() {
//     // Fill this in.
//     expect(latestResult.getText()).toEqual('10');
//   });
// });

// STEP 4
describe('Protractor Demo App', function() {
  var firstNumber = element(by.model('first'));
  var secondNumber = element(by.model('second'));
  var goButton = element(by.id('gobutton'));
  var latestResult = element(by.binding('latest'));
  var history = element.all(by.repeater('result in memory'));

  function add(a, b) {
    firstNumber.sendKeys(a);
    secondNumber.sendKeys(b);
    goButton.click();
  }

  beforeEach(function() {
    browser.get('http://juliemr.github.io/protractor-demo/');
  });

  it('should have a history', function() {
    add(1, 2);
    add(3, 4);

    expect(history.count()).toEqual(2);

    add(5, 6);

    expect(history.count()).toEqual(0); // This is wrong!
  });
});