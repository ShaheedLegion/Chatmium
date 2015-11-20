package inspirational.designs;

typedef UserData = {
	var name: String;
	var ip: String;
};

typedef CommandData = {
	var name: String;
	var displayText: String;
};

typedef ContentData = { 
	var name: String;
	var content: String;
	var contentType: String;
};

/**
 * This class is meant to be completely abstract, and it it up to the implementor
 * to make sure these functions are tied to the UI in some way.
 * 
 * @author Shaheed Abdol
 */
class DataHandler {

	public function AddUser(user: UserData) { }
	public function RemoveUser(user: UserData) { }
	
	public function AddCommand(command: CommandData) { }
	public function RemoveCommand(command: CommandData) { }
	
	public function AddContent(content: ContentData) { }
	public function RemoveContent(content: ContentData) {}
	
}
