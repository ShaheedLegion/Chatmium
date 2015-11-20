package inspirational.designs;

/**
 * This class interacts directly with the UI.
 * 
 * @author Shaheed Abdol
 */
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.controls.Image;
import haxe.ui.toolkit.controls.Scroll;
import haxe.ui.toolkit.core.PopupManager.PopupButton;
import haxe.ui.toolkit.core.renderers.BasicItemRenderer;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.core.interfaces.IDisplayObject;
import haxe.ui.toolkit.controls.TextInput;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.events.FocusEvent;
import openfl.events.MouseEvent;
import inspirational.designs.DataHandler;
import inspirational.designs.CustomItemRenderer;

class UIController extends XMLController implements UITextListener {
	
	private var originalY: Float;
	
	public function new() {
		super("assets/expandablepanel.xml");
		
		originalY = 0;
		attachEvent("alias", MouseEvent.CLICK, function(e) { getAliasPopup(); } );
		//attachEvent("upfile", MouseEvent.CLICK, function(e) { uploadFile(); } );
		//attachEvent("send", MouseEvent.CLICK, function(e) { sendMessage(); } );
		attachEvent("messageinput", FocusEvent.FOCUS_IN, function(e) { inputFocusChanged(true); } );
		attachEvent("messageinput", FocusEvent.FOCUS_OUT, function(e) { inputFocusChanged(false); } );
		
		TextListenerManager.getInstance().setTextListener(this);
		
		// Set up the renderer for the listview.
		var sv: ListView = getComponentAs("chatpanel", ListView);
		if (sv != null)
			sv.itemRenderer = new CustomItemRenderer();
	}
	
	private function uploadFile(): Void {
		// Try to upload a file.
		trace("Tring to upload a file.");
	}
	
	private function sendMessage(): Void {
		//var editField: TextInput = getComponentAs("message", TextInput);
		//var message: String = editField.text;
		//trace("Sending message: " + message);
		
		// Clear it out when we're done sending the message.
		//editField.text = "";
	}
	
	public function AddUserEntry(user: UserData) {
		//var usersList: ListView = getComponentAs("users", ListView);
		//trace("Adding user entry." + user.name);
		
		//usersList.dataSource.add({text:user.name});
	}

	public function RemoveUserEntry(user: UserData) { }
	
	public function AddCommandEntry(command: CommandData) { }
	public function RemoveCommandEntry(command: CommandData) { }
	
	public function AddContentEntry(content: ContentData) { }
	public function RemoveContentEntry(content: ContentData) { }

	private function getAliasPopup():Void {
		var controller:AliasInputController = new AliasInputController();
		var config:Dynamic = { };
		//config.buttons = [PopupButton.OK];
		config.modal = true;
		showCustomPopup(controller.view, "Set Alias", config);
	}
	
	private function inputFocusChanged(focussed: Bool) {
		trace("Text input focus changed: " + focussed);
		
		var parentBox: HBox = getComponentAs("dark2", HBox);
		if (parentBox == null)
			return;

		if (focussed) {
			// Try to move the popup to the top of the screen.
			trace("Moving the input.");
			originalY = parentBox.y;
			parentBox.y = 0;
		} else {
			// Try to move the popup back to where it was.
			trace("Moving the input.");
			parentBox.y = originalY;
			
			var input: TextInput = getComponentAs("messageinput", TextInput);
			if (input == null)
				return;
			
			// This is incorrect.
			// Send the message off - when it comes back, we push it to our display list.
			var listener: UITextListener = TextListenerManager.getInstance().getTextListener();
			if (listener != null) {
				listener.handleMessageText(input.text);
				input.text = "";
			}
		}
	}
	
	public function handleAliasText(text: String): Void {
		if (text != null) {
			trace("User set their alias " + text);
			
			var userList: ListView = getComponentAs("users", ListView);
			if (userList != null) {
				userList.dataSource.add( { "text": text } );
			}
		}
		
	}
	public function handleFileUploadText(text: String): Void {}
	public function handleMessageText(text: String): Void {
		// This is the hard part.
		var sv: ListView = getComponentAs("chatpanel", ListView);
		if (sv != null) {
			//var img: Image = new Image();
			var bitmapData = Assets.getBitmapData ("assets/slinky.jpg");
			var pathItem: String = Assets.getPath("assets/slinky.jpg");
			//img.resource = Assets.getBitmapData ("assets/slinky.jpg");
			sv.dataSource.add( { "text": "me:", "subtext": text, "icon":  "assets/slinky.jpg"} );
		}
	}
}