import Foundation

public func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	let pivot = a[high] //1
	
	var i = low //2
	for j in low..<high { //3
		if a[j] <= pivot { //4
			a.swapAt(i, j) //5
			i += 1
		}
	}
	
	a.swapAt(i, high) //6
	return i //7
}
