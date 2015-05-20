//webdriver-manager start
//python -m SimpleHTTPServer

describe('Home Page', function() {
  beforeEach(function() {
    browser.get('http://localhost:8000/');
  });

  it('should have the correct title', function() {
    expect(browser.getTitle()).toEqual('My Angular App');
  });
})