component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise::reject' , function() {

			it( 'to be a function that returns a Promise' , function() {

				expect( Promise::reject ).toBeTypeOf( 'function' );

				var actual = Promise::reject( 'something funky' );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );


				try {

					actual.done();

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