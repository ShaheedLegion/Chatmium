package inspirational.designs;

/**
 * This class deals with server comms.
 * 
 * @author Shaheed Abdol
 */
import inspirational.designs.DataHandler;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.ProgressEvent;
import openfl.net.Socket;
import openfl.utils.Endian;

typedef Header = {
  var type: UInt;     // PacketType.
  var flags: UInt;    // packet flags.
  var parts: UInt;    // parts in a complete transaction.
  var current: UInt;  // current part.
  var len: UInt;      // length of packet data.
  var sequence: UInt; // sequence tracker for packets.
  var id: UInt;       // similar to flags, but used for files.
};

typedef Packet = {
  var hdr: Header ;
  var data: String;
};

typedef PacketInfo = {
  var packet: Packet;
  var sent: Bool;
  var skips: Int;
};

class DataProducer {
	private static var ip: String = "10.0.14.74";
	private static var port: Int = 54547;
	
	private static var SALT = 0x16540000;

	// Alias is the first thing sent to the server.
	private static var PKT_ALIAS = 0x00002;
	private static var PKT_ALIAS_ACK = 0x00003;

	// The client periodically sends a query to the server.
	private static var PKT_QRY = 0x00004;
	private static var PKT_QRY_ACK = 0x00005;

	// The client sends a message to the server.
	private static var PKT_MSG = 0x00006;
	private static var PKT_MSG_ACK = 0x00007;

	// The client sends a private message to the server.
	private static var PKT_PVT = 0x00008;
	private static var PKT_PVT_ACK = 0x00009;

	// The client requests the user list from the server.
	private static var PKT_LST = 0x00010;
	private static var PKT_LST_ACK = 0x00011;

	// Client sending file to the server.
	private static var PKT_FILE_OUT = 0x00012;
	private static var PKT_FILE_OUT_ACK = 0x00013;

	// Server sending file to the client.
	private static var PKT_FILE_IN = 0x00014;
	private static var PKT_FILE_IN_ACK = 0x00015;
	
	private var handler: DataHandler = null;
	private var socket: Socket = null;
	private var userAlias: UserData = null;
	
	public function new(handler: DataHandler) {
		this.handler = handler;
		
		// This class will deal with networking.
		socket = new Socket();
		//socket.endian = Endian.LITTLE_ENDIAN;
		socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
		socket.addEventListener(Event.CONNECT, onConnect);
	}
	
	public function setAlias(alias: UserData) {
		userAlias = alias;
		socket.connect(ip, port);
	}
	
	private function onConnect(event: Event): Void {
		trace("socket connected");
		
		if (userAlias != null) {
			// try to send the alias to the server.
			// Create the connect message with our alias.
			var aliasPacket: PacketInfo  = {
				packet : {  hdr : {
					type : PKT_ALIAS,
					flags : 0,
					parts : 0,
					current : 0,
					len : userAlias.name.length,
					sequence : 4,
					id : 0,
					},
					data : userAlias.name,
				},
				sent : false,
				skips : 0,
			};
			sendPacket(aliasPacket);
		}
	}
	
	private function onClose(event: Event): Void {
		trace("socket closed");
	}
	
	private function onError(event: Event): Void {
		trace("socket error");
	}
	
	// This might require bit twiddling.
	private function htonl(i: UInt): UInt { return i; } 
	
	private function sendPacket(packetInfo: PacketInfo) {
		// Push the entire packet header + data to the vector.
		var upscaledData: Array<UInt> = new Array();
		upscaledData.push(htonl(packetInfo.packet.hdr.type));
		upscaledData.push(htonl(packetInfo.packet.hdr.flags));
		upscaledData.push(htonl(packetInfo.packet.hdr.parts));
		upscaledData.push(htonl(packetInfo.packet.hdr.current));
		upscaledData.push(htonl(packetInfo.packet.hdr.len));
		upscaledData.push(htonl(packetInfo.packet.hdr.sequence));
		upscaledData.push(htonl(packetInfo.packet.hdr.id));

		trace("Have array with length " + upscaledData.length);
		for (d in 0...packetInfo.packet.data.length)
		  upscaledData.push(htonl(cast(packetInfo.packet.data.charCodeAt(d), UInt) + SALT));

		for (i in upscaledData)
			socket.writeUnsignedInt(i);
	}
	
	
	private function onData(event: ProgressEvent): Void {
		// We have fetched some data from the server.
		trace("Got data - " + event.bytesLoaded + " - " + event.bytesTotal);
	}
}
