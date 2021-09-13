import Foundation

protocol HotDrink {
	func consume()
}

class Tea: HotDrink {
	func consume() {
		debugPrint("Consuming Tea...")
	}
}

class Coffee: HotDrink {
	func consume() {
		debugPrint("Consuming Coffee...")
	}
}

protocol HotDrinkFactory {
	init()
	func prepare(amount: Int) -> HotDrink
}

class TeaFactory {
	required init() {}
	
	func prepare(amount: Int) -> HotDrink {
		debugPrint("Preparing Tea with amount = \(amount)")
		return Tea()
	}
}

class CoffeeFactory {
	required init() {}
	
	func prepare(amount: Int) -> HotDrink {
		debugPrint("Preparing Coffee with amount = \(amount)")
		return Coffee()
	}
}

class HotDrinkMachine {
	enum AvailableDrink: String {
		case coffee = "Coffee"
		case tea = "Tea"
		static let all = [tea, coffee]
	}
	
	internal var factories = [AvailableDrink: HotDrinkFactory]()
	internal var namedFactories = [(String, HotDrinkFactory)]()
		
	init() {
		for drink in AvailableDrink.all {
			if let type = NSClassFromString("\(drink.rawValue)Factory") as? HotDrinkFactory.Type {
				let factory = type.init()
				factories[drink] = factory
				namedFactories.append((drink.rawValue, factory))
			}
		}
	}
	
	func makeDrink() -> HotDrink {
		debugPrint("Available Drinks:")
		for index in 0 ..< namedFactories.count {
			let currentTuple = namedFactories[index]
			debugPrint("\(index): \(currentTuple.0)")
		}
		let input = 0	// let's say it came from user using readLine()
		return namedFactories[input].1.prepare(amount: 250)
	}
}


let machine = HotDrinkMachine()
let drink = machine.makeDrink()
drink.consume()
