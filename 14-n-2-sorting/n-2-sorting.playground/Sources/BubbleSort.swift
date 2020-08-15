import Foundation

//public func bubbleSort<Element> (_ array: inout [Element])
//	where Element: Comparable {
//		//1
//		guard array.count >= 2 else {
//			return
//		}
//		//2
//		for end in (1 ..< array.count).reversed() {
//			var swapped = false
//			//3
//			for current in 0 ..< end {
//				if array[current] > array[current + 1] {
//					array.swapAt(current, current + 1)
//					swapped = true
//				}
//			}
//			//4
//			if !swapped {
//				return
//			}
//		}
//}

public func bubbleSort<T>(_ collection: inout T)
	where T: MutableCollection, T.Element: Comparable {
		//1
		guard collection.count >= 2 else {
			return
		}
		//2
		for end in collection.indices.reversed() {
			var swapped = false
			//3
			var current = collection.startIndex
			while current < end {
				let next = collection.index(after: current)
				if collection[current] > collection[next] {
					collection.swapAt(current, next)
					swapped = true
				}
				current = next
			}
			//4
			if !swapped {
				return
			}
		}
}
