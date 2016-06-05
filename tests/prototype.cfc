component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Promise.prototype' , function() {

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

				expect( actual ).toHaveKey( 'done' );
				expect( actual.done ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'finally' );
				expect( actual.finally ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'value' );
				expect( actual.done ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'thread_name' );
				expect( actual.thread_name ).toBeTypeOf( 'string' );

				expect( actual.value() ).toBe( '' );
				expect( actual.done() ).toBe( '' );

			} );

			it( 'returns a value when the callback hits resolve' , function() {

				var actual = new Promise( function( resolve , reject ) {

					resolve( 'resolved' );

				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );
				expect( actual.done() ).toBe( 'resolved' );

			} );

			it( 'throws an error when the callback hits reject' , function() {


				var actual = new Promise( function( resolve , reject ) {

					reject( 'rejected' );

				} );

				expect( actual ).toBeTypeOf( 'component' );
				expect( actual ).toBeInstanceOf( 'source.plugins.Promise' );

				try {

					actual.done();

					fail( 'Value on a rejected promise not throwing expected error' );

				} catch ( Promise.rejected e ) {

					expect( e.message ).toBe( 'rejected' );

				} catch ( any e ) {

					fail( 'Value on a rejected promise not throwing expected error' );

				}

			} );

		} );

	}

}