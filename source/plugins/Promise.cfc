component {

	public function init( 
		required function callback 
	) {

		this.thread_name = CreateUUID();

		fire_off_callback( arguments.callback );

		this.return_structure = {
			value: this
		};

		return this.return_structure.value;

	}

	public function then( 
		function onFulfilled , 
		function onRejected 
	) {
		arguments.onFulfilled = arguments.onFulfilled ?: function( data ) {
			return arguments.data;
		};

		arguments.onRejected = arguments.onRejected ?: function( data ) {
			throw( 
				type = 'Promise.rejected',
				message = arguments.data
			);
		};

		try {
			var response_value = this.value(); 
		} catch ( Promise.rejected e ) {
			return arguments.onRejected( e.message );
		}

		return arguments.onFulfilled( response_value );

	}


	public function catch(
		function onRejected
	) {
		return then(
			argumentCollection = arguments
		);
	}

	public function value() {

		thread
			name = this.thread_name
			action = 'join';

		var thread_response = cfthread[ this.thread_name ];

		if ( !( thread_response.success ?: true ) ) {

			throw( 
				type = 'Promise.rejected',
				message = thread_response.value ?: ''
			);

		}

		return thread_response.value ?: NullValue();

	}

	public static function all(
		required array iteratable
	) {

		var input = arguments.iteratable.map( function( resolve_me ) {
			if ( IsInstanceOf( arguments.resolve_me , 'Promise' ) ) {
				return arguments.resolve_me;
			}
			return Promise::resolve( arguments.resolve_me );
		} );

		return new Promise( function( resolve , reject ) {

			var response = input.map( function( resolve_me ) {
				return arguments.resolve_me
					.catch( function( error ) {
						reject( error );
					} );
			} );

			resolve( response );

		} );

	}

	public static function race(
		required array iteratable
	) {

		if ( arguments.iteratable.len() == 0 ) {
			throw( type = 'Promise.race_is_empty' );
		}

		return Promise::resolve( arguments.iteratable[1].value() );

	}

	public static function resolve( required data ) {

		var args = arguments;

		return new Promise( function( resolve , reject ) {

			resolve( argumentCollection = args );

		} );

	}

	public static function reject( required data ) {

		var args = arguments;

		return new Promise( function( resolve , reject ) {

			reject( argumentCollection = args );

		} );

	}

	private function fire_off_callback(
		required function callback
	) {


		thread
			name = this.thread_name
			action = 'run'
			callback = arguments.callback
			{

				var callback_method = attributes.callback;;

				callback_method(
					function( data ) {

						thread.success = true;
						thread.value = arguments.data;
						abort;

					},
					function( data ) {

						thread.success = false;
						thread.value = arguments.data;
						abort;

					}
				);

			}



	}

}