// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public struct QueueArray<T>: Queue {
	private var array: [T] = []
	public init() {}
	
	public var isEmpty: Bool {
		return array.isEmpty //1
	}
	
	public var peek: T? {
		return array.first //2
	}
	
	public mutating func enqueue(_ element: T) -> Bool {
		array.append(element)
		return true
	}
	
	public mutating func dequeue() -> T? {
		return isEmpty ? nil : array.removeFirst()
	}
	
}

extension QueueArray: CustomStringConvertible {
	public var description: String {
		return array.description
	}
}

//
var queue = QueueArray<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue.dequeue()
queue
queue.peek
