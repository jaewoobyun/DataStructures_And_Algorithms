import Foundation

public func medianOfThree<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	let center = (low + high) / 2
	if a[low] > a[center] {
		a.swapAt(low, center)
	}
	if a[low] > a[high] {
		a.swapAt(low, high)
	}
	if a[center] > a[high] {
		a.swapAt(center, high)
	}
	
	return center
}
