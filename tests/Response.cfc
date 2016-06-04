component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Response.cfc' , function() {

			it( 'has expected keys which are functions with a null value' , function() {

				var actual = new source.plugins.Response( function() {} );

				expect( actual ).toBeStruct();

				expect( actual ).toHaveKey( 'then' );
				expect( actual.then ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'catch' );
				expect( actual.catch ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'value' );
				expect( actual.value ).toBeTypeOf( 'function' );

				expect( actual.value() ).toBeNull();

			} );

		});



	}

}