class CodeBuilder: CustomStringConvertible {
	
	private var buffer = ""
	
	init() {}
	init(_ buffer: String) {
		self.buffer = buffer
	}
	
	func append(_ element: String) -> CodeBuilder {
		buffer.append(element)
		return self
	}
	
	func appendLine(_ element: String) -> CodeBuilder {
		buffer.append("\(element)\n")
		return self
	}
	
	static func += (codeBuilder: inout CodeBuilder, element: String) {
		codeBuilder.buffer.append(element)
	}
	
	var description: String {
		return buffer
	}
}

var codeBuilder = CodeBuilder()
codeBuilder.appendLine("class Foo {")
	.appendLine("    var element: String")
codeBuilder += "    // Testing codebuilder!!!\n"
codeBuilder.appendLine("}")
print(codeBuilder)