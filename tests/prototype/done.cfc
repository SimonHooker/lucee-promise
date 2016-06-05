component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.prototype.done' , function() {

			it( 'returns null value if used on a promise that has no value' , function() {

				var actual = new Promise( function() {} );

				expect( actual.done() ).toBe( '' );

			});

			describe( 'on resolve' , function() {

				it( 'returns a value without callback' , function() {

					var actual = Promise::resolve( 'resolve value' )
						.done();

					expect( actual ).toBe( 'resolve value' );

				} );

				it( 'hits onfulfilled and returns the value' , function() {


					var actual = Promise::resolve( 'resolve value' )
						.done(
							function( error_message ) {
								expect( error_message ).toBe( 'resolve value' );
								return 'done value';
							},
							function(){

								fail( 'Not expected to hit onrejected' );

							}
						);

					expect( actual ).toBe( 'done value' );

				} );

			} );

			describe( 'on reject' , function() {

				it( 'throws an error without callback' , function() {

					try {

						Promise::reject( 'reject value' )
							.done();

						fail( 'Value on a rejected promise not throwing expected error' );

					} catch ( Promise.rejected e ) {

						expect( e.message ).toBe( 'reject value' );

					} catch ( any e ) {

						fail( 'Value on a rejected promise not throwing expected error' );

					}

				} );

				it( 'hits onrejected and returns the value' , function() {


					var actual = Promise::reject( 'reject value' )
						.done(
							function(){

								fail( 'Not expected to hit onfulfilled' );

							},
							function( error_message ) {
								expect( error_message ).toBe( 'reject value' );
								return 'done value';
							}
						);

					expect( actual ).toBe( 'done value' );

				} );

			} );

		} );

	}

}