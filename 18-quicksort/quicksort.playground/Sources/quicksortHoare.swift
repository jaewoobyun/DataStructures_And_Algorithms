import Foundation

public func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	let pivot = a[low] //1
	var i = low - 1 //2
	var j = high + 1
	
	while true {
		repeat { j -= 1 } while a[j] > pivot //3
		repeat { i += 1 } while a[i] < pivot //4
		
		if i < j { //5
			a.swapAt(i, j)
		} else {
			return j //6
		}
	}
}
