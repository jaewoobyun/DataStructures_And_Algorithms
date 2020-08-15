import Foundation

//public func insertionSort<Element>(_ array: inout [Element])
//	where Element: Comparable {
//		guard array.count >= 2 else {
//			return
//		}
//		//1
//		//iterate from left to right once
//		for current in 1 ..< array.count {
//			//2
//			//run backwards from the current index so you can shift left as needed
//			for shifting in (1 ... current).reversed() {
//				//3
//				//keep shifting the element left as long as necessary
//				if array[shifting] < array[shifting - 1] {
//					array.swapAt(shifting, shifting - 1)
//				} else {
//					//
//					//as soon as element is in position, break the inner loop and start with the next element
//					break
//				}
//			}
//		}
//}


public func insertionSort<T>(_ collection: inout T)
	where T: BidirectionalCollection & MutableCollection ,T.Element: Comparable {
		guard collection.count >= 2 else {
			return
		}
		for current in collection.indices {
			var shifting = current
			while shifting > collection.startIndex {
				let previous = collection.index(before: shifting)
				if collection[shifting] < collection[previous] {
					collection.swapAt(shifting, previous)
				} else {
					break
				}
				shifting = previous
			}
		}
}
