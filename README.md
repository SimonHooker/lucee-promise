# lucee-promise

A Lucee 5 extension that allows use of Javascript-style promises wthin Lucee.  This extension aims to follow the [Promises/A+ specification](https://promisesaplus.com/)

## Installation

Drop `/dist/extension-lucee-promise-x.x.x.x.lex` into `{server|web-context}/deploy` and watch the fireworks.  By the time it is finished you should see a Promise.cfc in the root of your application, along with a folder /lucee-promise that contains the logic.  That is all.

## Usage

The syntax for lucee-promise is very similar to Javascript promises.  Documentation for this can be found in the [PromiseJS API documentation](https://www.promisejs.org/api/) and [Promise on MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise). The main differences are as follows

* In Lucee the promise at present does not automatically update itself with the resolved value.  To retrieve the final value you must use `promise_object.value()`
* Instead of `Promise.resolve( ... )` you must use `Promise::resolve( ... )`
* Instead of `Promise.reject( ... )` you must use `Promise::reject( ... )`
* Instead of `Promise.all( [ ] )` you must use `Promise::all( [ ] )`
* Instead of `Promise.race( [ ] )` you must use `Promise::race( [ ] )`

If you have any questions feel free to look me up on CFML Slack or anywhere you find me.  The tests are also worth checking for some code examples, in particular [/tests/core.cfc](https://github.com/SimonHooker/lucee-promise/blob/master/tests/core.cfc)

## Supported methods

* Promise.prototype.then( function( data ) {} , function( error_message ) {} )
* Promise.prototype.catch( function( error_message ) {} )
* Promise.all( array_of_promises_and_values )
* Promise.race( array_of_promises )
* Promise.resolve( value_to_return )
* Promise.reject( error_message )
