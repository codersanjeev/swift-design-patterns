import Foundation

class CodeBuilder: CustomStringConvertible {
	
	private var rootName: String
	private var properties: [String: String]
	
	init(_ rootName: String) {
		self.rootName = rootName
		self.properties = [String: String]()
	}
	
	func addField(called name: String, ofType type: String) -> CodeBuilder {
		properties[name] = type
		return self
	}
	
	public var description: String {
		var answer = "class \(rootName)\n{\n"
		properties.forEach { (name, type) in
			answer += "  "
			answer += "var \(name): \(type)\n"
		}
		answer += "}"
		return answer
	}
}
