package inspirational.designs;

/**
 * This class deals with binding the ui to the backend.
 * 
 * @author Shaheed Abdol
 */
import inspirational.designs.DataHandler;
 
class UIBinder extends DataHandler {
	public var controller: UIController = null;
	public var producer: DataProducer = null;
	
	public function new() {
		controller = new UIController();
		producer = new DataProducer(this);
	}
	
	public override function AddUser(user: UserData) {
		if (controller != null)
			controller.AddUserEntry(user);
	}

	public override function RemoveUser(user: UserData) { }
	
	public override function AddCommand(command: CommandData) { }
	public override function RemoveCommand(command: CommandData) { }
	
	public override function AddContent(content: ContentData) { }
	public override function RemoveContent(content: ContentData) {}
}