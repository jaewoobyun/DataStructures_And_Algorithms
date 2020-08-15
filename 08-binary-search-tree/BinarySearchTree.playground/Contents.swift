// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

var exampleTree: BinarySearchTree<Int> {
	var bst =  BinarySearchTree<Int>()
	bst.insert(3)
	bst.insert(1)
	bst.insert(4)
	bst.insert(0)
	bst.insert(2)
	bst.insert(5)
	return bst
}


example(of: "building a Binary Search Tree") {
	var bst = BinarySearchTree<Int>()
	for i in 0..<5 {
		bst.insert(i)
	}
	print(bst)
}

example(of: "balanced Binary Search Tree") {
	print(exampleTree)
}

example(of: "finding a node") {
	if exampleTree.contains(5) {
		print("Found 5!")
	} else {
		print("Coudn't find 5")
	}
}

example(of: "removing a node") {
	var tree = exampleTree
	print("Tree before removal: ")
	print(tree)
	
	tree.remove(3)
	print("Tree after removing root: ")
	print(tree)
}
