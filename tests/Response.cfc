component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Response.cfc' , function() {

			it( 'has expected keys which are functions' , function() {

				var actual = new source.Response();

				expect( actual ).toBeStruct();

				expect( actual ).toHaveKey( 'then' );
				expect( actual.then ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'catch' );
				expect( actual.catch ).toBeTypeOf( 'function' );

			} );


		});



	}

}