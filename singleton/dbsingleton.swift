import Foundation

class Database {
	var capitals = [String: Int]()
	static var instanceCount = 0
	
	// Singleton
	static let instance = Database()
	
	private init() {
		type(of: self).instanceCount += 1
	}
}

let database = Database.instance
debugPrint(Database.instanceCount)
let anotherDatabase = Database.instance
debugPrint(Database.instanceCount)
