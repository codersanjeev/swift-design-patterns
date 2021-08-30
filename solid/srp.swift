import Foundation

class Journal: CustomStringConvertible {
	var entries = [String]()
	var count = 0
	
	@discardableResult func addEntry(_ text: String) -> Int {
		count += 1
		entries.append("\(count): \(text)")
		return count - 1
	}
	
	func removeEntry(_ index: Int) {
		entries.remove(at: index)
	}
	
	var description: String {
		return entries.joined(separator: "\n")
	}
	
	///Adding below three functions in this class is breaking `Single Responsibility Principle`
	func save(_ filename: String, _ overwrite: Bool = false) {
		// Logic to save a file
	}
	
	func load(_ filename: String) {
		// Logic to load a file from filename
	}
	
	func load(_ url: URL) {
		// Logic to load a file from url
	}
}

/// Correct approach would be to separate out the Persistence logic to a different class
class Persistence {
	func save(journal: Journal, _ filename: String, _ overwrite: Bool = false) {
		// Logic to save a file
	}
	
	func load(journal: Journal, _ filename: String) {
		// Logic to load a file from filename
	}
	
	func load(journal: Journal, _ url: URL) {
		// Logic to load a file from url
	}
}

// MARK:- Usage
func main() {
	let journal = Journal()
	journal.addEntry("Entry Number 1")
	let secondIndex = journal.addEntry("Entry Number 2")
	print(journal)
	journal.removeEntry(secondIndex)
	print("----------------------------")
	print(journal)
	
	let persistence = Persistence()
	let filename = "/mnt/sdcard/downloads"
	persistence.save(journal: journal, filename, true)
}

main()
