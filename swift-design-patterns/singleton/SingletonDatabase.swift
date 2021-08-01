//
//  SingletonDatabase.swift
//  swift-design-patterns
//
//  Created by sanjeev on 01/08/21.
//

import Foundation

class SingletonDatabase {
	
	var capitals = [String:Int]()
	static var instanceCount = 0
	
	static let instance = SingletonDatabase()
	
	private init() {
		type(of: self).instanceCount += 1
		print("initializing database")
	}
	
}
