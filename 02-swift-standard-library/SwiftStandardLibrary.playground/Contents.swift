
/// Arrays

example(of: "Array") {
	// An array of 'String' elements
	var people = ["Brian", "Stanley", "Ringo"]

	print(people[0]) // "Brian"
	print(people[1]) // "Stanley"
	print(people[2]) // "Ringo"
	
	
	////  Insertion Location
	people.append("Chales")
	print(people) // prints ["Brian", "Stanley", "Ringo", Charles"]
	
	people.insert("Andy", at: 0)
	print(people) //["Andy", "Brian", "Stanley", "Ringo", Charles"]
	
}


///Dictionary
example(of: "Dictionary") {
	var scores: [String: Int] = ["Eric": 9, "Mark": 12, "Wayne": 1]
	
	scores["Andrew"] = 0
	
	print(scores)
}
