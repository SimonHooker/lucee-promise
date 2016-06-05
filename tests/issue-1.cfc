component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.prototype.then' , function() {

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