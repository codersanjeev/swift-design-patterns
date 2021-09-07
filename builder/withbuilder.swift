
class HTMLElement: CustomStringConvertible {
	var name = ""
	var text = ""
	var elements = [HTMLElement]()
	private let indentSize = 4
	
	init() {}
	init(name: String, text: String) {
		self.name = name
		self.text = text
	}
	
	var description: String {
		description(0)
	}
	
	private func description(_ indent: Int) -> String {
		var result = ""
		let indentString = String(repeating: " ", count: indent)
		result += "\(indentString)<\(name)>\n"
		if !text.isEmpty {
			result += String(repeating: " ", count: indent + 1)
			result += text
			result += "\n"
		}
		for element in elements {
			result += element.description(indent + 1)
		}
		result += "\(indentString)</\(name)>\n"
		return result
	}
}

class HTMLBuilder: CustomStringConvertible {
	private let rootName: String
	var root = HTMLElement()
	
	init(rootName: String) {
		self.rootName = rootName
		root.name = rootName
	}
	
	func addChild(name: String, text: String) {
		let element = HTMLElement(name: name, text: text)
		root.elements.append(element)
	}
	
	func addChildFluent(name: String, text: String) -> HTMLBuilder {
		let element = HTMLElement(name: name, text: text)
		root.elements.append(element)
		return self
	}
	
	func clear() {
		root = HTMLElement(name: rootName, text: "")
	}
	
	var description: String {
		root.description
	}
}

let builder = HTMLBuilder(rootName: "ul")
//builder.addChild(name: "li", text: "Hello")
//builder.addChild(name: "li", text: "World")
builder.addChildFluent(name: "li", text: "Hello")
	.addChildFluent(name: "li", text: "World")
print(builder)
