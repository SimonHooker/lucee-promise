component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.cfc' , function() {

			it( 'throws an error if the first argument is not provided' , function() {

				expect( function() {

					new Promise();

				} ).toThrow( 'Promise.init.missing_first_argument' );

			} );

			it( 'throws an error if the first argument is not a function' , function() {

				expect( function() {

					new Promise( 'test' );

				} ).toThrow( 'Promise.init.first_argument_must_be_a_callback_function' );

			} );

			it( 'returns a PromiseResponse' , function() {

				var actual = new Promise( function( resolve , reject ) {



				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.Response' );

			} );


		});

		describe( 'Promise::all' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::all ).toBeTypeOf( 'function' );

				var actual = Promise::all();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.Response' );

			} );

		} );

		describe( 'Promise::race' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::race ).toBeTypeOf( 'function' );

				var actual = Promise::race();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.Response' );

			} );

		} );

		describe( 'Promise::resolve' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::resolve ).toBeTypeOf( 'function' );

				var actual = Promise::resolve();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.Response' );


			} );

		} );

		describe( 'Promise::reject' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::reject ).toBeTypeOf( 'function' );

				var actual = Promise::reject();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.Response' );


			} );

		} );


	}

}