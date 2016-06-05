component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise::resolve' , function() {

			it( 'to be a function that returns a Promise' , function() {

				expect( Promise::resolve ).toBeTypeOf( 'function' );

				var actual = Promise::resolve( 'resolved value' );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

				expect( actual.done() ).toBe( 'resolved value' );


			} );

		} );

	}

}