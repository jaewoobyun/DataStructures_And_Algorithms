// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.



public struct QueueStack<T> : Queue {
	private var leftStack: [T] = []
	private var rightStack: [T] = []
	public init() {}
	
	public var isEmpty: Bool {
		return leftStack.isEmpty && rightStack.isEmpty
	}
	
	public var peek: T? {
		return !leftStack.isEmpty ? leftStack.last : rightStack.first
	}
	
	public mutating func enqueue(_ element: T) -> Bool {
		rightStack.append(element)
		return true
	}
	
	public mutating func dequeue() -> T? {
		if leftStack.isEmpty { //1
			leftStack = rightStack.reversed() //2
			rightStack.removeAll() //3
		}
		return leftStack.popLast() //4
	}
	
}

extension QueueStack: CustomStringConvertible {
	public var description: String {
		let printList = leftStack + rightStack.reversed()
		return printList.description
	}
}

var queue = QueueStack<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue.dequeue()
queue
queue.peek
