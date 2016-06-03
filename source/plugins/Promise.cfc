component {

	public function init( callback ) {

		if ( !IsDefined( 'arguments.callback' ) ) {
			throw( type = 'Promise.init.missing_first_argument' );
		}

		if ( !IsValid( 'function' , arguments.callback ) ) {
			throw( type = 'Promise.init.first_argument_must_be_a_callback_function' );
		}

		var value = '';
		var action = 'unfinished';

		callback(
			function( response ) {
				action = 'Resolve';
				value = arguments.response;
			},
			function( error ) {
				action = 'Reject';
				value = arguments.response;
			}
		);

		switch( action ) {
			case 'Resolve':
			case 'Reject':
				return CreateObject( action , value );
				break;
		}

		throw( type = 'Promise.init.not_resolved_or_rejected' );

	}

	public static function all() {
		return new Response();
	}

	public static function race() {
		return new Response();
	}

	public static function resolve() {
		return new Response();
	}

	public static function reject() {
		return new Response();
	}

}