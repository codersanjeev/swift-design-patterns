/**
 * Does not scale for complex HTML Builder as 
 * number of elements can be very large.
 * */
class HTMLBuilderOld {
	class func createAndPrintParagraph() {
		let hello = "Hello"
		let result = "<p>\(hello)</p>"
		print(result)
	}
	
	class func createAndPrintList() {
		let words = ["Hello", "World"]
		var result = "<ul>\n"
		for word in words {
			result.append("\t<li>\(word)</li>\n")
		}
		result.append("</ul>")
		print(result)
	}
}

HTMLBuilderOld.createAndPrintParagraph()
HTMLBuilderOld.createAndPrintList()