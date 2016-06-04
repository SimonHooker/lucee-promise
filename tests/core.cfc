component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.cfc' , function() {

			it( 'throws an error if the first argument is not provided' , function() {

				expect( function() {

					new Promise();

				} ).toThrow( 'expression' );

			} );

			it( 'throws an error if the first argument is not a function' , function() {

				expect( function() {

					new Promise( 'test' );

				} ).toThrow( 'expression' );

			} );

			it( 'has expected keys which are functions with a null value' , function() {

				var actual = new Promise( function() {} );

				expect( actual ).toBeStruct();

				expect( actual ).toHaveKey( 'then' );
				expect( actual.then ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'catch' );
				expect( actual.catch ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'value' );
				expect( actual.value ).toBeTypeOf( 'function' );

				expect( actual.value() ).toBeNull();

			} );

			it( 'returns a value when the callback hits resolve' , function() {

				var actual = new Promise( function( resolve , reject ) {

					resolve( 'resolved' );

				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );
				expect( actual.value() ).toBe( 'resolved' );

			} );

			it( 'throws an error when the callback hits reject' , function() {


				var actual = new Promise( function( resolve , reject ) {

					reject( 'rejected' );

				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

				try {

					actual.value();

					fail( 'Value on a rejected promise not throwing expected error' );

				} catch ( Promise.rejected e ) {

					expect( e.message ).toBe( 'rejected' );

				} catch ( any e ) {

					fail( 'Value on a rejected promise not throwing expected error' );

				}

			} );

			describe( '.then' , function() {

				it( 'hits onFulfilled and returns a value after a resolved promise with data' , function() {

					var actual = Promise::resolve( 'onfulfilled data' )
						.then(
							function( data ) {
								expect( arguments.data ).toBe( 'onfulfilled data' );
								return arguments.data;
							},
							function() {
								fail( 'Not expected to run the onRejected method' );
							}
						);

					expect( actual ).toBe( 'onfulfilled data' );

				} );



				it( 'defaults onFulfilled to just return the value from the preceeding promise' , function() {

					var actual = Promise::resolve( 'default onfulfilled data' )
						.then();

					expect( actual ).toBe( 'default onfulfilled data' );

				} );

				it( 'hits onRejected and returns a value after a resolved promise with data' , function() {

					var actual = Promise::reject( 'onrejected message' )
						.then(
							function() {
								fail( 'Not expected to run the onFulfilled method' );
							},
							function( error ) {
								expect( arguments.error ).toBe( 'onrejected message' );
								return arguments.error;
							}
						);

					expect( actual ).toBe( 'onrejected message' );

				} );

				it( 'defaults onRejected to just rethrow the error from the preceeding promise' , function() {


					var actual = Promise::reject( 'rethrown error' );

					expect( actual ).toBeTypeOf( 'component' );
					expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

					try {

						actual.then();

						fail( 'Value on a rejected promise not throwing expected error' );

					} catch ( Promise.rejected e ) {

						expect( e.message ).toBe( 'rethrown error' );

					} catch ( any e ) {

						fail( 'Value on a rejected promise not throwing expected error' );

					}

				} );

				it( 'can be chained' , function() {

					var actual = Promise::resolve( [ 1 ] )
						.then(
							function( data ) {
								data.add( 2 );
								return Promise::resolve( data );
							}
						)
						.then(
							function( data ) {
								data.add( 3 );
								return Promise::resolve( data );
							}
						)
						.then(
							function( data ) {
								data.add( 4 );
								return Promise::resolve( data );
							}
						)
						.then(
							function( data ) {
								data.add( 5 );
								return Promise::resolve( data );
							}
						);

					var actual_value = actual.value();

					expect( actual_value ).toBeArray();
					expect( actual_value ).toHaveLength( 5 )

					for ( var i = 1; i <= 5; i++ ) {
						expect( actual_value[ i ] ).toBe( i );
					} 

				} );


			} );

			describe( '.catch' , function() {

				it( 'behaves the same as hitting onRejected in a then' , function() {

					var actual = Promise::reject( 'catch message' )
						.catch(
							function( error ) {
								expect( arguments.error ).toBe( 'catch message' );
								return arguments.error;
							}
						);

					expect( actual ).toBe( 'catch message' );

				} );

				it( 'defaults in the same way as onRejected in then()' , function() {

					var actual = Promise::reject( 'rethrown catch' );

					expect( actual ).toBeTypeOf( 'component' );
					expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

					try {

						actual.catch();

						fail( 'Value on a rejected promise not throwing expected error' );

					} catch ( Promise.rejected e ) {

						expect( e.message ).toBe( 'rethrown catch' );

					} catch ( any e ) {

						fail( 'Value on a rejected promise not throwing expected error' );

					}

				} );

				it( 'can be chained' , function() {

					var actual = Promise::resolve( [ 1 ] )
						.then(
							function( data ) {
								data.add( 2 );
								return Promise::resolve( data );
							}
						)
						.then(
							function( data ) {
								data.add( 3 );
								return Promise::resolve( data );
							}
						)
						.then(
							function( data ) {
								data.add( 4 );
								return Promise::resolve( data );
							}
						)
						.then(
							function( data ) {
								data.add( 5 );
								return Promise::resolve( data );
							}
						);

					var actual_value = actual.value();

					expect( actual_value ).toBeArray();
					expect( actual_value ).toHaveLength( 5 )

					for ( var i = 1; i <= 5; i++ ) {
						expect( actual_value[ i ] ).toBe( i );
					} 

				} );


			} );

		});

		describe( 'Promise::all' , function() {

			it( 'to be a function that returns a Promise' , function() {

				expect( Promise::all ).toBeTypeOf( 'function' );

				var actual = Promise::all( [] );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

				var actual_value = actual.value();

				expect( actual_value ).toBeArray();
				expect( actual_value ).toHaveLength( 0 );

			} );

			it( 'returns values from resolved promises in the order they were provided' , function() {

				var start_ms = GetTickCount();
				var actual = Promise::all( [
					Promise::resolve( 'quick 1' ),
					new Promise( function( resolve , reject ) {
						sleep( 1000 );
						resolve( 'slow 1' );
					} ),
					Promise::resolve( 'quick 2' ),
					new Promise( function( resolve , reject ) {
						sleep( 500 );
						resolve( 'slow 2' );
					} ),
					Promise::resolve( 'quick 3' )
				] );


				var actual_value = actual.value();

				expect( actual_value ).toBeArray();
				expect( actual_value ).toHaveLength( 5 );
				expect( actual_value ).toBe( [
					'quick 1',
					'slow 1',
					'quick 2',
					'slow 2',
					'quick 3'
				] );

				// This will just prove that the threads are executed in series instead of parallel
				var time_taken = GetTickCount() - start_ms;
				expect( time_taken ).toBeGT( 999 ); // Slowest thread is 1000 ms
				expect( time_taken ).toBeLT( 1400 ); // If in parallel, should be at least 1500ms wait

			} );

			it( 'converts non-promises within the array to one and resolves' , function() {

				var actual = Promise::all( [
						Promise::resolve( 'promise 1' ),
						'not a promise',
						Promise::resolve( 'promise 2' )
					] )
					.value();

				expect( actual ).toBe( [
					'promise 1',
					'not a promise',
					'promise 2'
				] );

			} );

			it( 'rejects if anything rejects' , function() {

				var actual = Promise::all( [
						Promise::resolve( 'promise 1' ),
						Promise::reject( 'reject 1' )
					] )
					.then(
						function() {
							fail( 'Not expected to run the onFulfilled method' );
						},
						function( error ) {
							expect( arguments.error ).toBe( 'reject 1' );
							return arguments.error;
						}
					);

				expect( actual ).toBe( 'reject 1' );

			} );

		} );

/*
		describe( 'Promise::race' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::race ).toBeTypeOf( 'function' );

				var actual = Promise::race( [] );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

			} );

		} );
*/

		describe( 'Promise::resolve' , function() {

			it( 'to be a function that returns a Promise' , function() {

				expect( Promise::resolve ).toBeTypeOf( 'function' );

				var actual = Promise::resolve( 'resolved value' );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

				expect( actual.value() ).toBe( 'resolved value' );


			} );

		} );

		describe( 'Promise::reject' , function() {

			it( 'to be a function that returns a Promise' , function() {

				expect( Promise::reject ).toBeTypeOf( 'function' );

				var actual = Promise::reject( 'something funky' );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );


				try {

					actual.value();

					fail( 'Value on a rejected promise not throwing expected error' );

				} catch ( Promise.rejected e ) {

					expect( e.message ).toBe( 'something funky' );

				} catch ( any e ) {

					fail( 'Value on a rejected promise not throwing expected error' );

				}

			} );

		} );

	}

}