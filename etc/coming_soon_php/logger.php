<?
$filename    = "followers.txt";
$wrongEmails = array("admin", "administartion", "administrator", "adm", "cmwsu", "cmw.su", "cmw_su", "cmw-su", "cmw");
if (isset($_POST["commit"]) and isset($_POST["email"]) and !empty($_POST["email"])) {
	$domainName = substr(strrchr($_POST["email"], "@"), 1);
	$emailText  = str_replace("@".$domainName, "", $_POST["email"]);
	if (filter_var($_POST["email"], FILTER_VALIDATE_EMAIL) and !in_array($emailText, $wrongEmails) and $emailText != "#") {
		$email = $_POST["email"]."\n";
		if(!in_array($email, file($filename))){
			if (is_writable($filename)) {
				$handle = fopen($filename, "a");
				if (!$handle or fwrite($handle, $email) === false) {
					$response = unknownError();
					exit;
				}
				$response = array(
					"type"    => "success",
					"message" => "Спасибо. Мы лично сообщим Вам об открытии сайта."
				);
				fclose($handle);
			} else {
				$response = unknownError();
			}
		} else {
			$response = array(
				"type"    => "warning",
				"message" => "Ваш email уже существует в нашей базе данных."
			);
		}
	} else {
		$response = array(
			"type"    => "warning",
			"message" => "Похоже, вы допустили ошибку."
		);
	}
	echo json_encode($response);
} else {
	header("Location: /");
}

function unknownError() {
	$response = array(
		"type"    => "warning",
		"message" => "Непредвиденная ошибка. Не волнуйтесь, мы уже знаем о ней."
	);
	return $response;
}

?>