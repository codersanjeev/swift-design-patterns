class SingletonTester
{
	static func isSingleton(factory: () -> AnyObject) -> Bool
	{
		let objectOne = factory()
		let objectTwo = factory()
		return objectOne === objectTwo
	}
}
