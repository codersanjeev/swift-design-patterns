class CombinationLock {
	var status = ""
	private let combination: [Int]
	private var current = [Int]()
	
	init(_ combination: [Int]) {
		self.combination = combination
		self.status = "LOCKED"
	}
	
	func enterDigit(_ digit: Int) {
		if self.status == "LOCKED" {
			self.status = ""
		}
		status += String(digit)
		current.append(digit)
		if combination == current {
			status = "OPEN"
		} else if combination.count == current.count {
			self.status = "ERROR"
		}
	}
}
