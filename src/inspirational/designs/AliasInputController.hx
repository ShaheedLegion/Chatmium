package inspirational.designs;

import haxe.ui.toolkit.controls.popups.Popup;
import haxe.ui.toolkit.controls.TextInput;
import haxe.ui.toolkit.core.PopupManager;
import openfl.events.FocusEvent;
import haxe.ui.toolkit.core.XMLController;

class AliasInputController extends XMLController {
	
	private var originalY: Float;
	
	public function new() {
		super("assets/aliasinput.xml");
		
		originalY = 0;
		
		attachEvent("aliasfield", FocusEvent.FOCUS_IN, function(e) { inputFocusChanged(true); } );
		attachEvent("aliasfield", FocusEvent.FOCUS_OUT, function(e) { inputFocusChanged(false); } );
	}

	private function inputFocusChanged(focussed: Bool) {
		trace("Text input focus changed: " + focussed);
		
		var aliasPopup: Popup = get_popup();
		if (aliasPopup == null)
			return;

		if (focussed) {
			// Try to move the popup to the top of the screen.
			trace("Moving the popup.");
			originalY = aliasPopup.y;
			aliasPopup.y = 0;
		} else {
			// Try to move the popup back to where it was.
			trace("Moving the popup.");
			
			var aliasInput: TextInput = getComponentAs("aliasfield", TextInput);
			if (aliasInput != null) {
				var text: String = aliasInput.text;
				if (text == null || text.length < 6)
					return;
			
			
				aliasPopup.y = originalY;
				var listener: UITextListener = TextListenerManager.getInstance().getTextListener();
				if (listener != null)
					listener.handleAliasText(text);
			}
			// Hide ourselves since the job is done.
			PopupManager.instance.hidePopup(aliasPopup);
		}
	}
}