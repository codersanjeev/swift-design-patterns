class Command {
	enum Action {
		case deposit
		case withdraw
	}
	
	var action: Action
	var amount: Int
	var success = false
	
	init(_ action: Action, _ amount: Int) {
		self.action = action
		self.amount = amount
	}
}

class Account {
	var balance = 0
	
	func process(_ command: Command) {
		switch command.action {
			case .deposit:
				balance += command.amount
				command.success = true
			case .withdraw:
				if balance >= command.amount {
					balance -=  command.amount
					command.success = true
				} else {
					command.success = false
				}
		}
	}
}
