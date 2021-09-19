import Foundation

protocol Invocalble: AnyObject {
	func invoke(_ data: Any)
}

protocol Disposable {
	func dispose()
}

class Subscription<T: AnyObject, U>: Invocalble, Disposable {
	weak var target: T? = nil
	let handler: (T) -> (U) -> ()
	let event: Event<U>
	
	init(_ target: T?, handler: @escaping (T) -> (U) -> (), event: Event<U>) {
		self.target = target
		self.handler = handler
		self.event = event
	}
	
	func invoke(_ data: Any) {
		if let target = target, let data = data as? U {
			handler(target)(data)
		}
	}
	
	func dispose() {
		event.eventHandlers = event.eventHandlers.filter {
			$0 as AnyObject? !== self
		}
	}
}

class Event<T> {
	typealias EventHandler = (T) -> ()
	var eventHandlers = [Invocalble]()
	
	func raise(_ data: T) {
		eventHandlers.forEach {
			$0.invoke(data)
		}
	}
	
	func addHandler<U: AnyObject>(
		target: U,
		handler: @escaping (U) -> EventHandler
	) -> Disposable {
		return Subscription(target, handler: handler, event: self)
	}
}
