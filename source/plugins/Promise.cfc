component {

	public function init( 
		required function callback 
	) {

		return new Response( arguments.callback );

	}

	public static function all() {
		return new Response( function() {} );
	}

	public static function race() {
		return new Response( function() {} );
	}

	public static function resolve() {
		return new Response( function() {} );
	}

	public static function reject() {
		return new Response( function() {} );
	}

}