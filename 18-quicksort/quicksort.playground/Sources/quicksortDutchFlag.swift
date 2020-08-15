import Foundation

public func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
	let pivot = a[pivotIndex]
	var smaller = low //1
	var equal = low //2
	var larger = high //3
	while equal <= larger { //4
		if a[equal] < pivot {
			a.swapAt(smaller, equal)
			smaller += 1
			equal += 1
		} else if a[equal] == pivot {
			equal += 1
		} else {
			a.swapAt(equal, larger)
			larger -= 1
		}
	}
	
	return (smaller, larger) //5
}
