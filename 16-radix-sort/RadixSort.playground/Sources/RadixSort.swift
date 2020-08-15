import Foundation



extension Array where Element == Int {
	
	public mutating func radixSort() {
		//1
		// sorting base 10 ints. store it in constant base
		let base = 10
		//2
		//'done' serves as flag that determines whether sort is complete. 'digits' keep track of current digit you're looking at
		var done = false
		var digits = 1
		while !done {
			
			done = true
			//Bucket Sort
			
			//1
			//instantiate buckets using 2d array. base 10 -> 10 buckets.
			var buckets: [[Int]] = .init(repeating: [], count: base)
			//2
			// place each number in the correct bucket.
			forEach { (number) in
				let remainingPart = number / digits
				let digit = remainingPart % base
				buckets[digit].append(number)
				if remainingPart > 0 {
					done = false
				}
			}
			//3
			//update digits to next digit you wish to inspect and update the array using the contents of buckets. flatMap flatten the 2d array to 1d array, emptying the buckets into the array.
			digits *= base
			self = buckets.flatMap{ $0 }
		}
	}
	
}
