import Foundation

class User {
	static var strings = [String]()
	private var names = [Int]()
	
	init(_ fullName: String) {
		names = fullName.components(separatedBy: " ").map { s in
			if let index = type(of: self).strings.firstIndex(of: s) {
				return index
			} else {
				type(of: self).strings.append(s)
				return type(of: self).strings.count - 1
			}
		}
	}
	
	static var charCount: Int {
		return strings.map{ $0.count }.reduce(0, +)
	}
}

let userOne = User("John Smith")
let userTwo = User("Jane Smith")
let userThree = User("Jane Doe")

debugPrint("Total number of characters used = \(User.charCount)")
