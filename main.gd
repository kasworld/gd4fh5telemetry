extends Node2D

var dial_scene = preload("res://dial_speed/dial_speed.tscn")

var server := UDPServer.new()
var peers = []


func _ready():
	for x in range(240,1920,240*2):
		for y in range(250,1080,250*2):
			add_dial_at(Vector2(x,y))
	server.listen(4242)

func add_dial_at(p :Vector2)->DialSpeed:
	var d = dial_scene.instantiate()
	add_child(d)
	d.init()
	d.position = p
	return d

func _process(delta):
	server.poll() # Important!
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		print("Received data: %s" % [packet.get_string_from_utf8()])
		# Reply so it knows we received the message.
		peer.put_packet(packet)
		# Keep a reference so we can keep contacting the remote peer.
		peers.append(peer)

	for i in range(0, peers.size()):
		pass # Do something with the connected peers.
