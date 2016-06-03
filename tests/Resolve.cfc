component extends='testbox.system.BaseSpec' {

	function run() {

		describe( 'Resolve.cfc' , function() {

			it( 'has expected keys which are functions' , function() {

				var actual = new source.plugins.Resolve();

				expect( actual ).toBeInstanceOf( 'source.plugins.Response' );
				expect( actual ).toBeStruct();

				expect( actual ).toHaveKey( 'then' );
				expect( actual.then ).toBeTypeOf( 'function' );

				expect( actual ).toHaveKey( 'catch' );
				expect( actual.catch ).toBeTypeOf( 'function' );

			} );


		});



	}

}