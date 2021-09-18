import Foundation

class BankAccount: CustomStringConvertible {
	private var balance = 0
	private let overdraftLimit = -500
	
	func deposit(_ amount: Int) {
		balance += amount
		debugPrint("Deposited \(amount), Balance \(balance)")
	}
	
	func withdraw(_ amount: Int) -> Bool {
		guard balance - amount >= overdraftLimit else { return false }
		balance -= amount
		debugPrint("Withdrew \(amount), Balance \(balance)")
		return true
	}
	
	var description: String {
		return "Balance = \(balance)"
	}
}

protocol Command {
	func call()
	func undo()
}

class BankAccountCommand: Command {
	private var account: BankAccount
	private var action: Action
	private var amount: Int
	private var success = false
	
	enum Action {
		case deposit
		case withdraw
	}
	
	init(_ account: BankAccount, _ action: Action, _ amount: Int) {
		self.account = account
		self.action = action
		self.amount = amount
	}
	
	func call() {
		switch action {
			case .deposit:
				account.deposit(amount)
				success = true
			case .withdraw:
				success = account.withdraw(amount)
		}
	}
	
	func undo() {
		if !success { return }
		switch action {
			case .deposit:
				account.withdraw(amount)
			case .withdraw:
				account.deposit(amount)
		}
	}
}

let account = BankAccount()
let commands = [
	BankAccountCommand(account, .deposit, 100),
	BankAccountCommand(account, .withdraw, 25)
]
print(account)
commands.forEach { $0.call() }
print(account)
commands.reversed().forEach { $0.undo() }
print(account)
