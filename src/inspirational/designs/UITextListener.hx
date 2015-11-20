package inspirational.designs;


interface UITextListener {
	public function handleAliasText(text: String): Void;
	public function handleFileUploadText(text: String): Void;
	public function handleMessageText(text: String): Void;
}