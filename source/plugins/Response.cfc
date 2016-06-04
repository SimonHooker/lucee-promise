component {

	public function init(
		required function callback
	) {

		this.return_value = NullValue();

		callback(
			function( response ) {
				return_value = new Resolve(  );
			},
			function( error ) {
				return_value = new Reject(  );
			}
		);

		return this;

	}

	public function then() {

	}

	public function catch() {


	}

	public function value() {

		return this.return_value;

	}

}