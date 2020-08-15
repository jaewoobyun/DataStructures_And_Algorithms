import Foundation

public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
	// 1
	// base case. "exit condition"
	guard array.count > 1 else {
		return array
	}
	let middle = array.count / 2
	// 2
	// left and right halves
	let left = mergeSort(Array(array[..<middle]))
	let right = mergeSort(Array(array[middle...]))
	
	return merge(left, right)
}

private func merge<Element>(_ left: [Element], _ right: [Element]) -> [Element] where Element: Comparable {
	//1
	//tracks progress as you parse through the two arrays
	var leftIndex = 0
	var rightIndex = 0
	//2
	// result array house the combined array
	var result: [Element] = []
	//3
	// compare elements in left and right arrays sequentially.
	while leftIndex < left.count && rightIndex < right.count {
		let leftElement = left[leftIndex]
		let rightElement = right[rightIndex]
		//4
		// the smaller of the two elements goes into the result array. If the eleements are equal, both are added
		if leftElement < rightElement {
			result.append(leftElement)
			leftIndex += 1
		} else if leftElement > rightElement {
			result.append(rightElement)
			rightIndex += 1
		} else {
			result.append(leftElement)
			leftIndex += 1
			result.append(rightElement)
			rightIndex += 1
		}
	}
	//5
	// first loop guarantees either left or right is empty. Since both arrays are sorted, this ensures that the leftover elements are greater than or equal to the ones currently in result. In this scenario, you can append the rest of the elements without comparison.
	if leftIndex < left.count {
		result.append(contentsOf: left[leftIndex...])
	}
	if rightIndex < right.count {
		result.append(contentsOf: right[rightIndex...])
	}
	
	return result
}
