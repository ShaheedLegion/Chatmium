package inspirational.designs;

/**
 * This class deals with server comms.
 * 
 * @author Shaheed Abdol
 */
import inspirational.designs.DataHandler;

class DataProducer {

	private var handler: DataHandler;
	
	public function new(handler: DataHandler) {
		this.handler = handler;
		
		var user: UserData = { name: "Waaf3", ip: "127.0.0.1" };
		handler.AddUser(user);
	}
	
}
