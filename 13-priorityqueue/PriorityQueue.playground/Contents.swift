// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

struct PriorityQueue<Element: Equatable>: Queue {

	//1
	
	private var heap: Heap<Element> //2
	
	init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) { //3
		heap = Heap(sort: sort, elements: elements)
	}
	
	//
	var isEmpty: Bool {
		return heap.isEmpty
	}
	
	var peek: Element? {
		return heap.peek()
	}
	
	mutating func enqueue(_ element: Element) -> Bool {
		//1
		heap.insert(element)
		return true
	}
	
	mutating func dequeue() -> Element? {
		//2
		return heap.remove()
	}

}

print("\n---------- [ > ] ----------\n")
var priorityQueue = PriorityQueue(sort: >, elements: [1,12,3,4,1,6,8,7])
while !priorityQueue.isEmpty {
	print(priorityQueue.dequeue()!)
}
print("\n---------- [ < ] ----------\n")
var priorityQueue2 = PriorityQueue(sort: <, elements: [1,12,3,4,1,6,8,7])
while !priorityQueue2.isEmpty {
	print(priorityQueue2.dequeue()!)
}
