import Foundation

class Creature: CustomStringConvertible {
	var name: String
	var attack, defence: Int
	
	init(_ name: String, attack: Int, defence: Int) {
		self.name = name
		self.attack =  attack
		self.defence = defence
	}
	
	var description: String {
		return "Name = \(name), Attack = \(attack), Defence = \(defence)"
	}
}

class CreatureModifier {
	let creature: Creature
	var next: CreatureModifier?
	
	init(_ creature: Creature) {
		self.creature = creature
	}
	
	func add(_ creatureModifier: CreatureModifier) {
		if let next = next {
			next.add(creatureModifier)
		} else {
			next = creatureModifier
		}
	}
	
	func handle() {
		next?.handle()	// Chain
	}
}

class DoubleAttackModifier: CreatureModifier {
	override func handle() {
		debugPrint("Doubling \(creature.name)'s attack")
		creature.attack *= 2
		super.handle()
	}
}

class IncreaseDefenceModifier: CreatureModifier {
	override func handle() {
		debugPrint("Increasing \(creature.name)'s defence")
		creature.defence += 3
		super.handle()
	}
}

class NoBonusModifier: CreatureModifier {
	override func handle() {
		/// Do Nothing Here
	}
}

let creature = Creature("Goblin", attack: 2, defence: 2)
print(creature)

let root = CreatureModifier(creature)

// Double power
root.add(DoubleAttackModifier(creature))
print(creature)

// Increase defence
root.add(IncreaseDefenceModifier(creature))
print(creature)

root.handle()
print(creature)
