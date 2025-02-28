import Foundation

public class TreeNode<T> {
	public var value: T
	public var children: [TreeNode] = []
	
	public init(_ value: T) {
		self.value = value
	}
	
	// MARK: methods
	
	public func add(_ child: TreeNode) {
		children.append(child)
	}
	
	
}

// MARK: - Depth-first traversal
extension TreeNode {
	public func forEachDepthFirst(visit: (TreeNode) -> Void) {
		visit(self)
		children.forEach{
			$0.forEachDepthFirst(visit: visit)
		}
	}
}

// MARK: - Level-order traversal
extension TreeNode {
	public func forEachLevelOrder(visit: (TreeNode) -> Void) {
		visit(self)
		var queue = Queue<TreeNode>()
		children.forEach{ queue.enqueue($0) }
		while let node = queue.dequeue() {
			visit(node)
			node.children.forEach{ queue.enqueue($0) }
		}
	}
}

// MARK: - Search
extension TreeNode where T: Equatable {
	public func search(_ value: T) -> TreeNode? {
		var result: TreeNode?
		forEachLevelOrder { (node) in
			if node.value == value {
				result = node
			}
		}
		return result
	}
}
