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

			it( 'throws an error if the promise does not resolve or reject' , function() {


				var actual = new Promise( function( resolve , reject ) {} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );

			} );

			it( 'returns a Resolve when the callback hits resolve' , function() {

				var actual = new Promise( function( resolve , reject ) {

					resolve( 'resolved' );

				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );

			} );

			it( 'returns a Reject when the callback hits reject' , function() {

				var actual = new Promise( function( resolve , reject ) {

					reject( 'rejected' );

				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );

			} );


		});

		describe( 'Promise::all' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::all ).toBeTypeOf( 'function' );

				var actual = Promise::all();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );

			} );

		} );

		describe( 'Promise::race' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::race ).toBeTypeOf( 'function' );

				var actual = Promise::race();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );

			} );

		} );

		describe( 'Promise::resolve' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::resolve ).toBeTypeOf( 'function' );

				var actual = Promise::resolve();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );


			} );

		} );

		describe( 'Promise::reject' , function() {

			it( 'to be a function that returns a Response' , function() {

				expect( Promise::reject ).toBeTypeOf( 'function' );

				var actual = Promise::reject();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );


			} );

		} );


	}

}