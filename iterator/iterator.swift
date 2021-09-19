import Foundation

class Node<T> {
	var value: T
	var left: Node<T>? = nil
	var right: Node<T>? = nil
	var parent: Node<T>? = nil
	
	init(_ value: T) {
		self.value = value
	}
	
	init(_ value: T, left: Node<T>, right: Node<T>) {
		self.value = value
		self.left = left
		self.right = right
		self.left?.parent = self
		self.right?.parent = self
	}
}

class Inorderterator<T>: IteratorProtocol {
	var current: Node<T>?
	var root: Node<T>
	var yieldedStart = false
	
	init(_ root: Node<T>) {
		self.root = root
		self.current = root
		while current?.left != nil {
			current = current?.left
		}
	}
	
	func next() -> Node<T>? {
		if !yieldedStart {
			yieldedStart = true
			return current
		} else {
			if current?.right != nil  {
				current = current?.right
				while current?.left != nil {
					current = current?.left
				}
				return current
			} else {
				var parent = current?.parent
				while parent != nil && current === parent?.right {
					current = parent
					parent = parent?.parent
				}
				current = parent
				return current
			}
		}
	}
	
	func reset() {
		current = root
		yieldedStart = false
	}
}

let root = Node(1, left: Node(2), right: Node(3))
let iterator = Inorderterator(root)
while let element = iterator.next() {
	debugPrint(element.value, terminator: " ")
}
