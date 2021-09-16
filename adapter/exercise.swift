class Square {
	var side = 0
	
	init(side: Int) {
		self.side = side
	}
}

protocol Rectangle {
	var width: Int { get }
	var height: Int { get }
}

extension Rectangle {
	var area: Int {
		return self.width * self.height
	}
}

class SquareToRectangleAdapter: Rectangle {
	var width: Int
	var height: Int
	
	init(_ square: Square) {
		self.width = square.side
		self.height = square.side
	}
}
