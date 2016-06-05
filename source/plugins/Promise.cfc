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

		var return_value = NullValue();

		try {

			try {

				var response_value = this.value(); 

				if ( !IsNull( response_value ) ) {

					return_value = arguments.onFulfilled( response_value ) ?: response_value;

				}

			} catch ( Promise.rejected e ) {

				return_value = arguments.onRejected( e.message ) ?: Promise::reject( e.message );

			}

		} catch ( Promise.rejected e ) {

			rethrow;

		} catch ( any e ) {

			return Promise::reject( e.detail ?: e.message ?: e.type );

		}

		if ( IsInstanceOf( return_value , 'Promise' ) ) {
			return return_value;
		}

		return Promise::resolve( return_value );

	}

	public function done(
		function onFulfilled,
		function onRejected
	) {

		return then( argumentCollection = arguments )
			.value();

	}

	public function catch(
		function onRejected
	) {
		return then(
			argumentCollection = arguments
		);
	}

	public function value() {

		if ( !IsDefined( 'this.thread_response' ) ) {

			thread
				name = this.thread_name
				action = 'join';

			this.thread_response = cfthread[ this.thread_name ];
			
		}

		var thread_response_value = this.thread_response.value ?: '';

		if ( !( this.thread_response.success ?: true ) ) {

			throw( 
				type = 'Promise.rejected',
				message = thread_response_value
			);

		}

		return thread_response_value;

	}

	public static function all(
		required array iteratable
	) {
		if ( arguments.iteratable.len() == 0 ) {
			return Promise::resolve( [] );
		}

		var input = arguments.iteratable.map( function( resolve_me ) {
			if ( IsInstanceOf( arguments.resolve_me , 'Promise' ) ) {
				return arguments.resolve_me;
			}
			return Promise::resolve( arguments.resolve_me );
		} );

		// Race to the end in case there is an error
		return Promise::race( 
				iteratable = input , 
				only_declare_rejection_the_winner = true 
			)
			.then(
				function( data ) {
					var response = input.map( function( resolve_me ) {
						return resolve_me.value();
					} );
					return Promise::resolve( response );
				},
				function( data ) {
					return Promise::reject( data );
				}
			);


	}

	public static function race(
		required array iteratable,
		boolean only_declare_rejection_the_winner = false
	) {

		if ( arguments.iteratable.len() == 0 ) {
			throw( type = 'Promise.race_is_empty' );
		}

		var race_thread_id = CreateUUID();

		var promise_thread_ids = arguments.iteratable.map( function( resolve_me ) {
			return resolve_me.thread_name;
		} );

		thread
			name = race_thread_id
			promise_thread_ids = promise_thread_ids
			action = 'run'
			only_declare_rejection_the_winner = arguments.only_declare_rejection_the_winner
			{
				var number_of_threads = attributes.promise_thread_ids.len();
				var have_completed = [];

				for( var i = 1; i <= number_of_threads; i++ ) {

					if ( !have_completed.find( attributes.promise_thread_ids[ i ] ) ) {

						switch( cfthread[ attributes.promise_thread_ids[ i ] ].status ) {
							case 'COMPLETED':
								have_completed.add( attributes.promise_thread_ids[ i ] );
								var winning_thread = cfthread[ attributes.promise_thread_ids[ i ] ];
								if (
									!attributes.only_declare_rejection_the_winner
									||
									!winning_thread.success
								) {
									thread.success = winning_thread.success;
									thread.value = winning_thread.value;
									abort;
									break;
								}

								if ( have_completed.len() >= number_of_threads ) {
									thread.success = true;
									thread.value = '';
									abort;
								}
						}

						sleep( 10 );

					}

					if ( i == number_of_threads ) {
						i = 0;
					}
				}
			}

		return new Promise( function( resolve , reject ) {

			thread
				name = race_thread_id
				action = 'join';

			if ( cfthread[ race_thread_id ].success ) {
				resolve( cfthread[ race_thread_id ].value );
			} else {
				reject( cfthread[ race_thread_id ].value );
			}

		} );

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