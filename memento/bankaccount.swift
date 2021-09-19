import Foundation

class Memento {
	let balance: Int
	
	init(_ balance: Int) {
		self.balance = balance
	}
}

class BankAccount: CustomStringConvertible {
	private var balance: Int
	private var changes = [Memento]()
	private var current = 0
	
	init(_ balance: Int) {
		self.balance = balance
		changes.append(Memento(balance))
	}
	
	func deposit(_ amount: Int) -> Memento {
		balance += amount
		let memento = Memento(balance)
		changes.append(memento)
		current += 1
		return memento
	}
	
	func restore(_ memento: Memento?) {
		if let memento = memento {
			balance = memento.balance
			changes.append(memento)
			current = changes.count - 1
		}
	}
	
	func undo() -> Memento? {
		guard current > 0 else { return nil }
		current -= 1
		let memento = changes[current]
		balance = memento.balance
		return memento
	}
	
	func redo() -> Memento? {
		guard current + 1 < changes.count else { return nil }
		current += 1
		let memento = changes[current]
		balance = memento.balance
		return memento
	}
	
	var description: String {
		return "Balance = \(balance)"
	}
}

var account = BankAccount(100)
let m1 = account.deposit(50)
let m2 = account.deposit(25)
//print(account)
//
//// restore
//account.restore(m1)
//print(account)
//
//account.restore(m2)
//print(account)

account.undo()
print("Undo One: \(account)")

account.undo()
print("Undo Two: \(account)")

account.redo()
print("Redo One: \(account)")
