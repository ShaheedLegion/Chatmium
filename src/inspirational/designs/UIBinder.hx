package inspirational.designs;

/**
 * This class deals with binding the ui to the backend.
 * 
 * @author Shaheed Abdol
 */
import inspirational.designs.DataHandler;
import openfl.net.SharedObject;

 
class UIBinder extends DataHandler {
	public var controller: UIController = null;
	public var producer: DataProducer = null;
	private var localStorage: SharedObject;
	
	public function new() {
		controller = new UIController(this);
		producer = new DataProducer(this);
		
		localStorage = SharedObject.getLocal("chatmium");
		
		// We stand between the UI and the network.
		// If attributes were previously set, then we can retrieve them.
		if (localStorage.size != 0 && localStorage.data != null) {
			var alias: UserData = localStorage.data.alias;
			if (alias != null)
				AddUser(alias);
				
			// If we had a valid alias, then we immediately connect to the server.
			producer.setAlias(alias);
		}
	}
	
	public override function AddUser(user: UserData) {
		if (controller != null) {
			controller.AddUserEntry(user);
			localStorage.data.alias = user;
		}
	}

	public override function RemoveUser(user: UserData) { }
	
	public override function AddCommand(command: CommandData) { }
	public override function RemoveCommand(command: CommandData) { }
	
	public override function AddContent(content: ContentData) { }
	public override function RemoveContent(content: ContentData) {}
}