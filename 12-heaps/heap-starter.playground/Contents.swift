// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.


struct Heap<Element: Equatable> {
	
	var elements: [Element] = []
	let sort: (Element, Element) -> Bool
	
	init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
		self.sort = sort
		
		//
		self.elements = elements
		
		if !elements.isEmpty {
			for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
				siftDown(from: i)
			}
		}
		
	}
	
	var isEmpty: Bool {
		return elements.isEmpty
	}
	
	var count: Int {
		return elements.count
	}
	
	func peek() -> Element? {
		return elements.first
	}
	
	func leftChildIndex(ofParentAt index: Int) -> Int {
		return (2 * index) + 1
	}
	
	func rightChildIndex(ofParentAt index: Int) -> Int {
		return (2 * index) + 2
	}
	
	func parentIndex(ofChildAt index: Int) -> Int {
		return (index - 1) / 2
	}
	
	mutating func remove() -> Element? {
		guard !isEmpty else { //1
			return nil
		}
		elements.swapAt(0, count - 1) //2
		defer {
			siftDown(from: 0) //4
		}
		return elements.removeLast() //3
	}
	
	mutating func siftDown(from index: Int) {
		var parent = index //1
		while true { //2
			let left = leftChildIndex(ofParentAt: parent)
			//3
			let right = rightChildIndex(ofParentAt: parent)
			
			var candidate = parent //4
			if left < count && sort(elements[left], elements[candidate]) {
				candidate = left //5
			}
			if right < count && sort(elements[right], elements[candidate]) {
				candidate = right //6
			}
			if candidate == parent {
				return //7
			}
			elements.swapAt(parent, candidate) //8
			parent = candidate
		}
	}
	
	mutating func insert(_ element: Element) {
		elements.append(element)
		siftUp(from: elements.count - 1)
	}
	
	mutating func siftUp(from index: Int) {
		var child = index
		var parent = parentIndex(ofChildAt: child)
		while child > 0 && sort(elements[child], elements[parent]) {
			elements.swapAt(child, parent)
			child = parent
			parent = parentIndex(ofChildAt: child)
		}
	}
	
	mutating func remove(at index: Int) -> Element? {
		guard index < elements.count else {
			return nil //1
		}
		if index == elements.count - 1 {
			return elements.removeLast() //2
		} else {
			elements.swapAt(index, elements.count - 1) //3
			
			defer {
				siftDown(from: index) //5
				siftUp(from: index)
			}
			return elements.removeLast() //4
		}
		
	}
	
	func index(of element: Element, startingAt i: Int) -> Int? {
		if i >= count {
			return nil //1
		}
		if sort(element, elements[i]) {
			return nil //2
		}
		if element == elements[i] {
			return i //3
		}
		if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
			return j	//4
		}
		if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
			return j	//5
		}
		return nil //6

	}

}



var heap = Heap(sort: >, elements: [1,12,3,4,1,6,8,7])

while !heap.isEmpty {
	print(heap.remove()!)
}
