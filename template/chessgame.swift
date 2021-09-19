import Foundation

class Game {
	internal var currentPlayer = 0
	internal let numberOfPlayers: Int
	
	init(_ numberOfPlayers: Int) {
		self.numberOfPlayers = numberOfPlayers
	}
	
	internal func start() {
		precondition(false)
	}
	
	internal func takeTurn() {
		precondition(false)
	}
	
	internal var haveWinner: Bool {
		false
	}
	internal var winningPlayer: Int {
		0
	}
	
	func run()  {
		start()
		while !haveWinner {
			takeTurn()
		}
		print("Player \(winningPlayer) wins")
	}
}

class Chess: Game {
	private let maxTurns = 10
	private var turn = 1
	
	init() {
		super.init(2)
	}
	
	override func start() {
		print("Starting chess with  \(numberOfPlayers)")
	}
	
	override var haveWinner: Bool {
		return turn == maxTurns
	}
	
	override var winningPlayer: Int {
		return currentPlayer
	}
	
	override func takeTurn() {
		print("Turn \(turn) taken by player \(currentPlayer)")
		currentPlayer = (currentPlayer + 1) % numberOfPlayers
		turn += 1
	}
}

let chess = Chess()
chess.run()
