component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.prototype.then' , function() {

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
					)
					.done();

				expect( actual ).toBe( 'onfulfilled data' );

			} );



			it( 'defaults onFulfilled to just return the value from the preceeding promise' , function() {

				var actual = Promise::resolve( 'default onfulfilled data' )
					.then()
					.done();

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
					)
					.done();

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

				var actual_value = actual.done();

				expect( actual_value ).toBeArray();
				expect( actual_value ).toHaveLength( 5 )

				for ( var i = 1; i <= 5; i++ ) {
					expect( actual_value[ i ] ).toBe( i );
				} 

			} );

			describe( 'onFulfilled' , function() {

				it( 'must return Promise::resolve( return ) when it returns a non-promise' , function() {

					Promise::resolve( 'resolve 1' )
					.then(
						function( data ) {
							return 'resolve 2';
						},
						function( error_message ) {
							fail( 'Should not hit rejected' );
						}
					)
					.then(
						function( data ) {
							expect( data ).toBe( 'resolve 2' );
						},
						function( error_message ) {
							fail( 'Should not hit rejected' );
						}
					);

				} );

				it( 'must return Promise::resolve( data ) when it does not return a value' , function() {
					Promise::resolve( 'resolve 1' )
					.then(
						function( data ) {
							// Nothing much happening
						},
						function( error_message ) {
							fail( 'Should not hit rejected' );
						}
					)
					.then(
						function( data ) {
							expect( data ).toBe( 'resolve 1' );
						},
						function( error_message ) {
							fail( 'Should not hit rejected' );
						}
					);
				} );

				it( 'must return Promise::reject( error_reason ) if it throws an error' , function() {

					Promise::resolve( 'resolve 1' )
					.then(
						function( data ) {
							throw( message = 'onfulfilled throw 1' );
						},
						function( error_message ) {
							fail( 'Should not hit rejected' );
						}
					)
					.then(
						function( data ) {
							fail( 'Should not hit resolved' );
						},
						function( error_message ) {
							expect( error_message ).toBe( 'onfulfilled throw 1' );
						}
					);

				} );

			} );

			describe( 'onRejected' , function() {


				it( 'must return Promise::resolve( return ) when it returns a non-promise' , function() {

					Promise::reject( 'reject 1' )
					.then(
						function( data ) {
							fail( 'Should not hit resolved' );
						},
						function( error_message ) {
							return 'resolve 1';
						}
					)
					.then(
						function( data ) {
							expect( data ).toBe( 'resolve 1' );
						},
						function( error_message ) {
							fail( 'Should not hit rejected' );
						}
					);

				} );

				it( 'must return Promise::reject( data ) when it does not return a value' , function() {

					Promise::reject( 'reject 1' )
					.then(
						function( data ) {
							fail( 'Should not hit resolved' );
						},
						function( error_message ) {
							// Nothing much going on here
						}
					)
					.then(
						function( data ) {
							fail( 'Should not hit resolved' );
						},
						function( error_message ) {
							expect( error_message ).toBe( 'reject 1' )
						}
					);

				} );

				it( 'must return Promise::reject( error_reason ) if it throws an error' , function() {

					Promise::reject( 'reject 1' )
					.then(
						function( data ) {
							fail( 'Should not hit resolved' );
						},
						function( error_message ) {
							throw( message = 'onrejected throw 1' );
						}
					)
					.then(
						function( data ) {
							fail( 'Should not hit resolved' );
						},
						function( error_message ) {
							expect( error_message ).toBe( 'onrejected throw 1' );
						}
					);

				} );

			} );

		} );

	}

}