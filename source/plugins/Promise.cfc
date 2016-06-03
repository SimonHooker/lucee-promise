component {

	public function init( callback ) {

		if ( !IsDefined( 'arguments.callback' ) ) {
			throw( type = 'Promise.init.missing_first_argument' );
		}

		if ( !IsValid( 'function' , arguments.callback ) ) {
			throw( type = 'Promise.init.first_argument_must_be_a_callback_function' );
		}



		return new Response();

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