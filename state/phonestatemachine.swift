enum State {
	case offHook
	case connecting
	case connected
	case onHold
}

enum Trigger {
	case callDialed
	case hungUp
	case callConnected
	case placedOnHold
	case takenOffHold
	case leftMessage
}

let rules = [
	State.offHook: [
		(Trigger.callDialed, State.connecting)
	],
	State.connecting: [
		(Trigger.leftMessage, State.offHook),
		(Trigger.hungUp, State.offHook),
		(Trigger.placedOnHold, State.onHold)
	],
	State.onHold: [
		(Trigger.takenOffHold, State.connected),
		(Trigger.hungUp, State.offHook)
	]
]

var state = State.offHook

while true {
	print("Phone is currently at: \(state)")
	print("Select a trigger: ")
	
	for index in rules[state]!.indices {
		let trigger = rules[state]![index].0
		print("\(index). \(trigger)")
	}
	
	if let input = Int(readLine()!) {
		let nextState = rules[state]![input].1
		state = nextState
	}
}
