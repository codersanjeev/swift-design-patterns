import Foundation

class Neuron: Sequence {
	var inputs = [Neuron]()
	var outputs = [Neuron]()
	
//	func connect(to neuron: Neuron) {
//		outputs.append(neuron)
//		neuron.inputs.append(self)
//	}
	
	func makeIterator() -> IndexingIterator<Array<Neuron>> {
		return IndexingIterator(_elements: [self])
	}
}

class NeuronLayer: Sequence {
	private var neurons: [Neuron]
	
	init(_ count: Int) {
		neurons = [Neuron](repeating: Neuron(), count: count)
	}
	
	func makeIterator() -> IndexingIterator<Array<Neuron>> {
		return IndexingIterator(_elements: neurons)
	}
}

extension Sequence {
	func connect<T: Sequence>(to element: T)
	where T.Iterator.Element == Neuron, Self.Iterator.Element == Neuron {
		for from in self {
			for to in element {
				from.outputs.append(to)
				to.inputs.append(from)
			}
		}
	}
}

let neuronOne = Neuron()
let neuronTwo = Neuron()
let layerOne = NeuronLayer(10)
let layerTwo = NeuronLayer(20)
neuronOne.connect(to: layerOne)