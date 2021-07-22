//
//  ISP.swift
//  swift-design-patterns
//
//  Created by sanjeev on 18/07/21.
//

import Foundation

// MARK:- Wrong Approach
protocol Payable {
	func payUsingCash()
	func payUsingDebitCard()
	func payUsingUpi()
}

class PaymentProcessor: Payable {
	func payUsingCash() {
		// logic to pay using cash
	}
	
	func payUsingDebitCard() {
		// logic to pay using debit card
	}
	
	func payUsingUpi() {
		print("we Don't support UPI yet.")
		// or maybe throw an Error
	}
}

// MARK:- Correct Approach
protocol CashPayable {
	func payUsingCash()
}

protocol DebitCardPayable {
	func payUsingDebitCard()
}

protocol UPIPayable {
	func payUsingUpi()
}

class PaymentProcessor: CashPayable, DebitCardPayable {
	func payUsingCash() {
		// logic to pay using cash
	}
	
	func payUsingDebitCard() {
		// logic to pay using debit card
	}
}
