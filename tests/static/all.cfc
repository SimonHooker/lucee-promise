component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise::all' , function() {

			it( 'to be a function that returns a Promise' , function() {

				expect( Promise::all ).toBeTypeOf( 'function' );

				var actual = Promise::all( [] );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

				var actual_value = actual.done();

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

				var actual_value = actual.done();

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
					.done();

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
					)
					.done();

				expect( actual ).toBe( 'reject 1' );

			} );

			it( 'rejects with the fastest rejection' , function() {

				var start_ms = GetTickCount();

				var actual = Promise::all( [
						new Promise( function( resolve , reject ) {
							sleep( 500 );
							reject( 'slept for 500' );
						} ),
						new Promise( function( resolve , reject ) {
							sleep( 100 );
							reject( 'slept for 100' );
						} )
					] )
					.then(
						function() {
							fail( 'Not expected to run the onFulfilled method' );
						},
						function( error ) {
							expect( arguments.error ).toBe( 'slept for 100' );
							return arguments.error;
						}
					)
					.done();

				var time_taken = GetTickCount() - start_ms;
				expect( time_taken ).toBeGT( 99 );
				expect( time_taken ).toBeLT( 200 ); 



				expect( actual ).toBe( 'slept for 100' );

			} );

		} );

	}

}