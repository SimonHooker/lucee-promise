component {

	public function init( 
		required function callback 
	) {

		this.thread_name = CreateUUID();

		fire_off_callback( arguments.callback );

		return this;

	}

	public function then( 
		function onFulfilled , 
		function onRejected 
	) {

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

/*
	public static function all(
		required array iteratable
	) {
		return new Response( function() {} );
	}

	public static function race(
		required array iteratable
	) {
		return new Response( function() {} );
	}

*/
	public static function resolve( data ) {

		var args = arguments;

		return new Promise( function( resolve , reject ) {

			resolve( argumentCollection = args );

		} );

	}

	public static function reject( data ) {

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