import Foundation

protocol Log {
	func info(_ message: String)
	func warn(_ message: String)
}

class ConsoleLog: Log {
	func info(_ message: String) {
		print("Information: \(message)")
	}
	
	func warn(_ message: String) {
		print("Warning: \(message)")
	}
}

class NullLog: Log {
	func info(_ message: String) {}
	func warn(_ message: String) {}
}

class BankAccount {
	var log: Log
	var balance = 0
	
	init(_ log: Log) {
		self.log = log
	}
	
	func deposit(_ amount: Int) {
		balance += amount
		log.info("Deposited \(amount), Balance \(balance)")
	}
}

let log = NullLog()
let account = BankAccount(log)
account.deposit(100)
