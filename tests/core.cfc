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


		});
/*
		describe( 'Promise::all' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::all ).toBeTypeOf( 'function' );

				var actual = Promise::all( [] );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

			} );

		} );

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