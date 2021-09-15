import Foundation

class Buffer {
	var height, width: Int
	var buffer: [Character]
	
	init(_ height: Int, _ width: Int) {
		self.height =  height
		self.width = width
		self.buffer = [Character](repeating: " ", count: height * width)
	}
	
	subscript(_ index: Int) -> Character {
		return buffer[index]
	}
}

class ViewPort {
	var buffer: Buffer
	var offset = 0
	
	init(_ buffer: Buffer) {
		self.buffer = buffer
	}
	
	func getCharacter(at index: Int) -> Character {
		return buffer[offset + index]
	}
}

class Console {
	var buffers = [Buffer]()
	var viewports = [ViewPort]()
	var offset = 0
	
	init() {
		let buffer = Buffer(20, 30)
		let viewport = ViewPort(buffer)
		buffers.append(buffer)
		viewports.append(viewport)
	}
	
	func getCharacter(at index: Int) -> Character {
		return viewports[0].getCharacter(at: index)
	}
}

let console = Console()
let ch = console.getCharacter(at: 1)
