import Foundation

class Person {
	var name: String
	var room: ChatRoom? = nil
	private var chatLogs = [String]()
	
	init(_ name: String) {
		self.name = name
	}
	
	func receive(_ sender: String, message: String) {
		print("[\(name)'s chat session] \(sender): `\(message)`")
		chatLogs.append("\(sender): `\(message)`")
	}
	
	func say(_ message: String) {
		room?.broadcast(name, message: message)
	}
	
	func privateMessage(_ receiver: String, message: String) {
		room?.message(name, receiver, message)
	}
}

class ChatRoom {
	private var people = [Person]()
	
	func broadcast(_ sender: String, message: String) {
		for person in people {
			if person.name != sender {
				person.receive(sender, message: message)
			}
		}
	}
	
	func join(_ person: Person) {
		broadcast("admin", message: "\(person.name) joined the chat")
		person.room = self
		people.append(person)
	}
	
	func message(_ sender: String, _ receiver: String, _ message: String) {
		people.first(where: { $0.name == receiver })?.receive(sender, message: message)
	}
}

let room = ChatRoom()
let john = Person("John")
let doe = Person("Doe")
room.join(john)
room.join(doe)
john.say("Hi!")
doe.say("Hello!")
let martin = Person("Martin")
room.join(martin)
martin.say("Hii!")
