component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise::race' , function() {

			it( 'to be a function that returns a Promise' , function() {

				expect( Promise::race ).toBeTypeOf( 'function' );

				var actual = Promise::race( [
					Promise::resolve( 'speed racer' )
				] );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

				var actual_value = actual.done();
				expect( actual_value ).toBe( 'speed racer' );

			} );

			it( 'throws an error if the array is empty' , function() {

				try {

					Promise::race( [] );

					fail( 'Race not failing with an empty array' )

				} catch ( Promise.race_is_empty e ) {

					// Working ok

				} catch ( any e ) {

					fail( 'Error thrown by empty error not as expected' );

				}

			} );

			it( 'returns the first element to resolve' , function() {

				var start_ms = GetTickCount();

				var actual = Promise::race( [
						Promise::resolve( 'quick' ),
						new Promise( function( resolve , reject ) {
							sleep( 100 );
							resolve( 'slow' );
						} )
					] )
					.done();

				var time_taken = GetTickCount() - start_ms;
				expect( time_taken ).toBeLT( 99 );

				expect( actual ).toBe( 'quick' );

			} );

			it( 'returns the fastest element to resolve' , function() {

				var start_ms = GetTickCount();

				var actual = Promise::race( [
						new Promise( function( resolve , reject ) {
							sleep( 100 );
							resolve( 'slow' );
						} ),
						Promise::resolve( 'quick' )
					] )
					.done();

				var time_taken = GetTickCount() - start_ms;
				expect( time_taken ).toBeLT( 99 );

				expect( actual ).toBe( 'quick' );

			} );

			it( 'ignores resolves when the reject only flag is true' , function() {

				var start_ms = GetTickCount();


				try {

					Promise::race( 
						iteratable = [
							Promise::resolve( 'quick resolve' ),
							new Promise( function( resolve , reject ) {
								sleep( 100 );
								reject( 'slow reject' );
							} )
						],
						only_declare_rejection_the_winner = true
					)
					.catch();

					fail( 'Race did not reject' );

				} catch ( Promise.rejected e ) {

					expect( e.message ).toBe( 'slow reject' );

				} catch ( any e ) {

					dump( e );
					fail( 'Race rejected with an unexpected error' );

				}

				var time_taken = GetTickCount() - start_ms;
				expect( time_taken ).toBeGT( 99 );

			} );

		} );

	}

}