class Participant {
	private let mediator: Mediator
	var value = 0
	
	init(_ mediator: Mediator) {
		self.mediator = mediator
		Mediator.participants.append(self)
	}
	
	func say(_ n: Int) {
		mediator.broadcast(from: self, n)
	}
}

class Mediator {
	static var participants = [Participant]()
	
	func broadcast(from participant: Participant, _ value: Int) {
		for receiver in type(of: self).participants {
			if receiver !== participant {
				receiver.value += value
			}
		}
	}
}
