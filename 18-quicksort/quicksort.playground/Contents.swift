// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let pivot = partitionLomuto(&a, low: low, high: high)
		quicksortLomuto(&a, low: low, high: pivot - 1)
		quicksortLomuto(&a, low: pivot + 1, high: high)
	}
}


var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]

quicksortLomuto(&list, low: 0, high: list.count - 1)
print(list)


public func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let p = partitionHoare(&a, low: low, high: high)
		quicksortHoare(&a, low: low, high: p)
		quicksortHoare(&a, low: p + 1, high: high)
	}
}

var list2 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]

quicksortHoare(&list2, low: 0, high: list2.count - 1)
print(list2)


public func quickSortMedian<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let pivotIndex = medianOfThree(&a, low: low, high: high)
		a.swapAt(pivotIndex, high)
		let pivot = partitionLomuto(&a, low: low, high: high)
		quicksortLomuto(&a, low: low, high: pivot - 1)
		quicksortLomuto(&a, low: pivot + 1, high: high)
	}
}

var list3 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quickSortMedian(&list3, low: 0, high: list3.count - 1)
print(list3)

public func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let (middleFirst, middleLast) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: high)
		quicksortDutchFlag(&a, low: low, high: middleFirst - 1)
		quicksortDutchFlag(&a, low: middleLast + 1, high: high)
	}
}

var list4 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortDutchFlag(&list4, low: 0, high: list4.count - 1)
print(list4)
