
class Node<T> {
	let value: T
	var left: Node<T>? = nil
	var right: Node<T>? = nil
	var parent: Node<T>? = nil
	
	init(_ value: T) {
		self.value = value
	}
	
	init(_ value: T, _ left: Node<T>, _ right: Node<T>) {
		self.value = value
		self.left = left
		self.right = right
		self.left?.parent = self
		self.right?.parent = self
	}
	
	private func preorder(_ node: Node<T>?) -> [T] {
		if let node = node {
			var ans = [node.value]
			ans += preorder(node.left)
			ans += preorder(node.right)
			return ans
		} else {
			return []
		}
	}
	
	public var preOrder: [T] {
		return preorder(self)
	}
}
