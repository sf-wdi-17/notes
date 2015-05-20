// conf.js

// STEP 3
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['spec.js'],
  multiCapabilities: [{
    browserName: 'firefox'
  }, {
    browserName: 'chrome'
  }]
}

// exports.config = {
//   seleniumAddress: 'http://localhost:4444/wd/hub',
//   specs: ['spec.js']
// }