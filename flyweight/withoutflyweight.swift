import Foundation

class User {
	var fullName: String
	
	init(_ fullName: String) {
		self.fullName = fullName
	}
	
	var charCount: Int {
		return  fullName.count
	}
}

let userOne = User("John Smith")
let userTwo = User("Jane Smith")
let userThree = User("Jane Doe")

let totalChars = userOne.charCount + userTwo.charCount + userThree.charCount
debugPrint("Total number of characters used = \(totalChars)")
