import Foundation

public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    // MARK: push()
    public mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    // MARK: append()
    public mutating func append(_ value: Value) {
        copyNodes()
        //1
        guard !isEmpty else {
            push(value)
            return
        }
        
        //2
        tail!.next = Node(value: value)
        
        //3
        tail = tail!.next
    }
    // MARK: node()
    public func node(at index: Int) -> Node<Value>? {
        //1
        var currentNode = head
        var currentIndex = 0
        
        //2
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    //1
    @discardableResult //lets callers ignore the return value of this method without the compiler jumping up and down warning you about it
    // MARK: insert()
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        //2
        guard tail !== node else {
            append(value)
            return tail!
        }
        //3
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    // MARK: pop()
    public mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    // MARK: removeLast()
    public mutating func removeLast() -> Value? {
        copyNodes()
        //1
        guard let head = head else {
            return nil
        }
        //2
        guard head.next != nil else {
            return pop()
        }
        //3
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        //4
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    // MARK: remove(after:)
    public mutating func remove(after node: Node<Value>) -> Value? {
        copyNodes()
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    // MARK: copyNodes()
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
}

// MARK: CustomStringConvertible protocol
extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
}
