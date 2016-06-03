component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.cfc' , function() {

			it( 'returns a PromiseResponse' , function() {

				var actual = new source.applications.Promise( function( resolve , reject ) {



				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.applications.PromiseResponse' );

			} );


		});

		describe( 'Promise::all' , function() {

			it( 'to be a function that returns a PromiseResponse' , function() {

				expect( source.applications.Promise::all ).toBeTypeOf( 'function' );

				var actual = source.applications.Promise::all();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.applications.PromiseResponse' );

			} );

		} );

		describe( 'Promise::race' , function() {

			it( 'to be a function that returns a PromiseResponse' , function() {

				expect( source.applications.Promise::race ).toBeTypeOf( 'function' );

				var actual = source.applications.Promise::race();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.applications.PromiseResponse' );

			} );

		} );

		describe( 'Promise::resolve' , function() {

			it( 'to be a function that returns a PromiseResponse' , function() {

				expect( source.applications.Promise::resolve ).toBeTypeOf( 'function' );

				var actual = source.applications.Promise::resolve();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.applications.PromiseResponse' );


			} );

		} );

		describe( 'Promise::reject' , function() {

			it( 'to be a function that returns a PromiseResponse' , function() {

				expect( source.applications.Promise::reject ).toBeTypeOf( 'function' );

				var actual = source.applications.Promise::reject();

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.applications.PromiseResponse' );


			} );

		} );


	}

}