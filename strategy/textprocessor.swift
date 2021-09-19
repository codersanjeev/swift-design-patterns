import Foundation

enum OutputFormat {
	case markdown
	case html
}

protocol ListStrategy {
	init()
	func start(_ buffer: inout String)
	func end(_ buffer: inout String)
	func addListItem(buffer: inout String, item: String)
}

class MarkdownListStrategy: ListStrategy {
	required init() {}
	func start(_ buffer: inout String) {}
	func end(_ buffer: inout String) {}
	func addListItem(buffer: inout String, item: String) {
		buffer.append(" * \(item)\n")
	}
}

class HtmlListStrategy: ListStrategy {
	required init() {}
	func start(_ buffer: inout String) {
		buffer.append("<ul>\n")
	}
	func end(_ buffer: inout String) {
		buffer.append("</ul>\n")
	}
	func addListItem(buffer: inout String, item: String) {
		buffer.append("  <li>\(item)</li>\n")
	}
}

class TextProcessor: CustomStringConvertible {
	private var buffer = ""
	private var listStrategy: ListStrategy
	
	init(_ outputFormat: OutputFormat) {
		switch outputFormat {
			case .markdown: listStrategy = MarkdownListStrategy()
			case .html: listStrategy = HtmlListStrategy()
		}
	}
	
	func setOutputFormat(_ outputFormat: OutputFormat) {
		switch outputFormat {
			case .markdown: listStrategy = MarkdownListStrategy()
			case .html: listStrategy = HtmlListStrategy()
		}
	}
	
	func appendList(_ items: [String]) {
		listStrategy.start(&buffer)
		items.forEach { listStrategy.addListItem(buffer: &buffer, item: $0) }
		listStrategy.end(&buffer)
	}
	
	func clear() {
		buffer = ""
	}
	
	var description: String {
		return buffer
	}
}

let textProcessor = TextProcessor(.markdown)
textProcessor.appendList(["john", "doe"])
print(textProcessor)
