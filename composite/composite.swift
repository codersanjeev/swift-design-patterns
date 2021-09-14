import Foundation

class GraphicObject: CustomStringConvertible {
	var name = "Group"
	var color = ""
	var  children = [GraphicObject]()
	
	init() {}
	init(name: String) {
		self.name = name
	}
	
	var description: String {
		var buffer = ""
		print(&buffer, 0)
		return buffer
	}
	
	private func print(_ buffer: inout String, _ depth: Int) {
		buffer.append(String(repeating: "*", count: depth))
		buffer.append(color.isEmpty ? "" : "\(color) ")
		buffer.append("\(name)\n")
		children.forEach { child in
			child.print(&buffer, depth + 1)
		}
	}
}

class Square: GraphicObject {
	init(_ color: String) {
		super.init(name: "Square")
		self.color = color
	}
}

class Circle: GraphicObject {
	init(_ color: String) {
		super.init(name: "Circle")
		self.color = color
	}
}

let drawing = GraphicObject()
drawing.children.append(Square("Red"))
drawing.children.append(Circle("Yellow"))

let group = GraphicObject()
group.children.append(Circle("Blue"))
group.children.append(Square("Blue"))

drawing.children.append(group)
print(drawing)