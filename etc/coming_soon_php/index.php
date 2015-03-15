<!DOCTYPE html>
<html lang="ru">
	<head>
		<meta charset="UTF-8" />
		<title>Coming Soon</title>
		<link rel="stylesheet" href="./stylesheets/application.css" />
		<meta name="viewport" content="maximum-scale=1, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<meta name="HandheldFriendly" content="true" />
		<meta name="description" content="" />
		<!--[if lt IE 9]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js" async></script>
			<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" async></script>
		<![endif]-->
		<!--[if lt IE 8]>
			<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js" async></script>
		<![endif]-->
	</head>
	<body class="z-unloaded">
		<div class="z-actions">
			<div class="z-actions__alerts"></div>
			<div class="z-actions__popups"></div>
		</div>
		<section class="b-wrapper">
			<header class="b-controller-name_auth">
				<div class="b-logo">
					<div>
						<a href="/" class="b-logo__image">
							<object data="/images/logo.svg">  
							    <img src="/images/logo.png" />  
							</object>
							<div class="b-logo__pointer"></div>
						</a>
					</div>
					<div>
						<a href="/" class="b-logo__text">Criticize My Work</a>
					</div>
				</div>
			</header>
			<main class="b-wrapper__main">
				<div class="b-page_login">
					<div class="b-auth">
						<div class="b-auth__title b-auth__title_with-link">
							В разработке
						</div>
						<div class="b-auth__welcome-text">
							Оставьте нам свой e-mail, и мы напишем Вам, когда сайт будет готов
						</div>
						<div class="b-auth__form">
							<form action="" data-hook="coming-soon" accept-charset="UTF-8" method="post">
								<div>
									<input name="email" data-hook="coming-soon-email" class="b-input_text b-input_text-login" type="text" placeholder="Email" />
								</div>
								<div class="g-clearfix b-auth__form-commit">
									<div class="g-right">
										<input name="commit" type="submit" class="b-button b-button_expanded" value="Подписаться" />
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</main>
			<footer>

			</footer>
		</section>
		<script src="./javascripts/application.js"></script>
		<script src="./javascripts/coming_soon.js"></script>
	</body>
</html>
