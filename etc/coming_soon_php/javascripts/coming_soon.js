"use strict";
CMW.Coming_soon = (function() {
	var _validator, _validateEmail, _unknownError;

	function Coming_soon() {
		_validator();
	}

	_validator = function() {
		var $this, $coming_soon_email, coming_soon_email_val;
		$.hook("coming-soon").on("submit", function(event) {
			event.preventDefault();
			$coming_soon_email    = $.hook("coming-soon-email");
			coming_soon_email_val = $coming_soon_email.val().trim();
			if (_validateEmail(coming_soon_email_val)) {
				$.ajax({
					url: "/logger.php",
					type: "POST",
					data: {
						email : coming_soon_email_val,
						commit: "commit"
					}
				})
				.done(function(data) {
					var json;
					try {
						json = JSON.parse(data);
						z_.alert({
							timeout: 10000,
							type   : json.type,
							message: json.message
						});
					} catch(e) {
						_unknownError();
					}
				})
				.fail(function() {
					_unknownError();
				});
			} else {
				z_.alert({
					timeout: 10000,
					type   : "warning",
					message: "Похоже, вы допустили ошибку."
				});
			};
		});
	};

	_validateEmail = function(email) { 
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(email);
	};

	_unknownError = function() {
		z_.alert({
			timeout: 10000,
			type   : "warning",
			message: "Непредвиденная ошибка. Не волнуйтесь, мы уже знаем о ней."
		});
	};

	return Coming_soon;

})();
