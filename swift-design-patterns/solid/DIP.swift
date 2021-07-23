//
//  DIP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 18/07/21.
//

import Foundation

class Person: Hashable, Equatable {
	var name: String
	
	init(_ name: String) {
		self.name = name
	}
	
	static func == (lhs: Person, rhs: Person) -> Bool {
		return lhs.name == rhs.name
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(self.name)
	}
}

// MARK:- Wrong Approach
class Network {
	var people = [Person : [Person]]()
	
	func makeFriends(_ u: Person, _ v: Person) {
		if people.contains(where: { $0.key == u }) {
			people[u]?.append(v)
		} else {
			people[u] = [v]
		}
		if people.contains(where: { $0.key == v }) {
			people[v]?.append(u)
		} else {
			people[v] = [u]
		}
	}
}

class FriendsSuggestion {
	var network: Network
	
	init(_ network: Network) {
		self.network = network
	}
	
	func findSuggestedFriends(forPerson person: Person) -> [Person] {
		var suggestedFriends = [Person]()
		network.people[person]?.forEach { friend in
			network.people[friend]?.forEach { suggestedFriend in
				suggestedFriends.append(suggestedFriend)
			}
		}
		return suggestedFriends
	}
}

// MARK:- Correct Approach
protocol FriendsSearchable {
	func findAllFriends(of person: Person) -> [Person]
}

class Network: FriendsSearchable {
	private var people = [Person : [Person]]()
	
	func makeFriends(_ u: Person, _ v: Person) {
		if people.contains(where: { $0.key == u }) {
			people[u]?.append(v)
		} else {
			people[u] = [v]
		}
		if people.contains(where: { $0.key == v }) {
			people[v]?.append(u)
		} else {
			people[v] = [u]
		}
	}
	
	func findAllFriends(of person: Person) -> [Person] {
		var friends = [Person]()
		people[person]?.forEach { friend in
			friends.append(friend)
		}
		return friends
	}
}

class FriendsSuggestion {
	var friends: FriendsSearchable
	
	init(_ friends: FriendsSearchable) {
		self.friends = friends
	}
	
	func findSuggestedFriends(forPerson person: Person) -> [Person] {
		var suggestedFriends = [Person]()
		friends.findAllFriends(of: person).forEach { friend in
			friends.findAllFriends(of: friend).forEach { suggestedFriend in
				suggestedFriends.append(suggestedFriend)
			}
		}
		return suggestedFriends
	}
}

let network = Network()

let personA = Person("A")
let personB = Person("B")
let personC = Person("C")
let personD = Person("D")

network.makeFriends(personA, personB)
network.makeFriends(personB, personC)
network.makeFriends(personB, personD)

let friendsSuggesion = FriendsSuggestion(network)
let suggestions = friendsSuggesion.findSuggestedFriends(forPerson: personA)
for friend in suggestions {
	print(friend.name)
}
