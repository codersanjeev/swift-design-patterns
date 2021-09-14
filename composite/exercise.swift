import Foundation

class SingleValue : Sequence {
	var value = 0
	
	init() {}
	
	init(_ value: Int) {
		self.value = value
	}
	
	func makeIterator() -> IndexingIterator<Array<Int>> {
		return IndexingIterator(_elements: [value])
	}
}

class ManyValues : Sequence {
	var values = [Int]()
	
	func makeIterator() -> IndexingIterator<Array<Int>> {
		return IndexingIterator(_elements: values)
	}
	
	func add(_ value: Int) {
		values.append(value)
	}
}

extension Sequence where Self.Iterator.Element == AnySequence<Int> {
	func sum() -> Int {
		var ans = 0
		for ele in self {
			ans += ele.reduce(0, +)
		}
		return ans
	}
}