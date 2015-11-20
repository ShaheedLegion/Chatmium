package inspirational.designs;

/**
 * ...
 * @author ...
 */
class TextListenerManager
{
	private var textListener: UITextListener;
	private static var instance: TextListenerManager = null;

	public static function getInstance() : TextListenerManager {
		if (instance == null)
			instance = new TextListenerManager();
			
		return instance;
	}
	
	private function new() 
	{
		textListener = null;
	}
	
	public function setTextListener(listener: UITextListener) {
		textListener = listener;
	}
	
	public function getTextListener(): Null<UITextListener> {
		return textListener;
	}
	
}