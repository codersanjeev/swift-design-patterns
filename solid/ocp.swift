
enum Color {
	case Red
	case Green
	case Blue
}

enum Size {
	case Small
	case Medium
	case Large
	case Huge
}

class Product {
	var name: String
	var color: Color
	var size: Size
	
	init(_ name: String, _ color: Color, _ size: Size) {
		self.name = name
		self.color = color
		self.size = size
	}
}

/// Incorrect Approach: Breaking `Open Closed Principle` due to following reasons:
//  - Modifying existing class for adding a new change request, instead we should be extending the existing class.
//  - Current approach is not scalable.
class ProductFilter {
	func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
		var result = [Product]()
		products.forEach { product in
			if product.color == color {
				result.append(product)
			}
		}
		return result
	}
	
	func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
		var result = [Product]()
		products.forEach { product in
			if product.size == size {
				result.append(product)
			}
		}
		return result
	}
	
	func filterBySizeAndColor(_ products: [Product], _ size: Size, _ color: Color) -> [Product] {
		var result = [Product]()
		products.forEach { product in
			if product.size == size && product.color == color {
				result.append(product)
			}
		}
		return result
	}
}

/// Correct approach would be use `Specification Pattern` for this particular problem
protocol Specification {
	associatedtype T
	func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
	associatedtype T
	func filter<S: Specification>(_ items: [T], _ specification: S) -> [T] where T == S.T
}

class ColorSpecification: Specification {
	typealias T = Product
	
	let color: Color
	
	init(_ color: Color) {
		self.color = color
	}
	
	func isSatisfied(_ item: Product) -> Bool {
		return item.color == color
	}
}

class SizeSpecification: Specification {
	typealias T = Product
	
	let size: Size
	
	init(_ size: Size) {
		self.size = size
	}
	
	func isSatisfied(_ item: Product) -> Bool {
		return item.size == size
	}
}

class AndSpecification<T,
					   SA: Specification,
					   SB: Specification>: Specification where
	SA.T == SB.T, T == SA.T {
	let specificationA: SA
	let specificationB: SB
	
	init(_ specificationA: SA, _ specificationB: SB) {
		self.specificationA = specificationA
		self.specificationB = specificationB
	}
	
	func isSatisfied(_ item: T) -> Bool {
		return specificationA.isSatisfied(item) && specificationB.isSatisfied(item)
	}
}

class CorrectProductFilter: Filter {
	typealias T = Product
	
	func filter<S: Specification>(_ items: [Product], _ specification: S) -> [Product] where T == S.T {
		var result = [Product]()
		items.forEach { item in
			if specification.isSatisfied(item) {
				result.append(item)
			}
		}
		return result
	}
}

// MARK:- Usage
func main() {
	let apple = Product("Apple", .Green, .Small)
	let tree = Product("Tree", .Green, .Large)
	let house = Product("House", .Blue, .Large)
	
	let products = [apple, tree, house]
	let productFilter = ProductFilter()
	print("Green products (old):")
	for product in productFilter.filterByColor(products, .Green) {
		print("- \(product.name) is Green")
	}
	
	let correctProductFilter = CorrectProductFilter()
	print("Green products (new):")
	for product in correctProductFilter.filter(products, ColorSpecification(.Green)) {
		print("- \(product.name) is Green")
	}
	
	print("Large Blue items")
	for product in correctProductFilter.filter(products, AndSpecification(ColorSpecification(.Blue), SizeSpecification(.Large))) {
		print("- \(product.name) is Large and Blue")
	}
}

main()
