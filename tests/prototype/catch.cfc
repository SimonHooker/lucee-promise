component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.prototype.catch' , function() {

			it( 'behaves the same as hitting onRejected in a then' , function() {

				var actual = Promise::reject( 'catch message' )
					.catch(
						function( error ) {
							expect( arguments.error ).toBe( 'catch message' );
							return arguments.error;
						}
					)
					.done();

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

				var actual_value = actual.done();

				expect( actual_value ).toBeArray();
				expect( actual_value ).toHaveLength( 5 )

				for ( var i = 1; i <= 5; i++ ) {
					expect( actual_value[ i ] ).toBe( i );
				} 

			} );


		} );

	}

}