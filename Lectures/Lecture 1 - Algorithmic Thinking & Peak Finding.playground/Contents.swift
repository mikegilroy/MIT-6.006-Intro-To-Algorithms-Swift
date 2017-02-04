/* 

******************************************
************** Peak Finding **************
******************************************

The lecture then covers 1-D and 2-D peak finding, using this problem to point out some issues involved in designing
efficient algorithms.



***** Lecture Notes *****


*** Peak Finding in a 1D Array ***

Peak Definition:

for an array [a,b,c,d,e,f,g,h,i] where a...i are integers
if b >= a  AND b >= c then peak = b

Objective:
To find a peak for a 1-D array

*/

let array = [7,2,5,6,7,8]


// Poor Performance Version - Linear
// Worst case complexity is Ø(n)

func find1DPeak<T: Integer>(forArray array: [T]) -> T {
	
	for (i,element) in array.enumerated() {
		
		let n = array.count - 1
		
		// Account for an array with only 1 element
		if array.count <= 1 {
			return element
		}
		
		// With each iteration of the array you are checking if the next element in the array is less than or equal to the current element. As we start from index 0, we know that if the next element is less than the current element, then the current element is a peak. This is because the previous element must be less than or equal to the current element or be the first element in the array to have got to this point.
		if i == n || element >= array[i+1] {
			return element
		}
	}
	
	// We will only reach here if array contains zero elements
	return -1
}

find1DPeak(forArray: array)


// Zero element example - You must declare argument type as an array of Integers as type cannot be inferred from an empty array. Trying to pass an empty array without typecasting will result in a compiler error.

find1DPeak(forArray: [] as [Int])



// Higher Performance Version - Logarithmic
// Here we use binary search/divide and conquer technique to improve the algorithms' performance to Ø(log^2(n))

func find1DPeakQuickly<T: Integer>(forArray array: [T]) -> T {
	
	// Account for zero element array
	if array.isEmpty {
		return -1
	}
	
	let n = array.count - 1
	let middleIndex = n/2
	
	if middleIndex == 0 {
		return array[middleIndex] 
	} else if array[middleIndex] <= array[middleIndex - 1] {
		// Take left slice of the array
		let leftArray = array[0...middleIndex-1]
		return find1DPeakQuickly(forArray: Array(leftArray))
	} else if array[middleIndex] <= array[middleIndex + 1] {
		// Take right slice of the array
		let rightArray = array[middleIndex+1...n]
		return find1DPeakQuickly(forArray:  Array(rightArray))
	} else {
		return array[middleIndex]
	}
}

find1DPeakQuickly(forArray: array)

// Zero element example - ou must declare argument type as an array of Integers as type cannot be inferred from an empty array. Trying to pass an empty array without typecasting will result in a compiler error.

find1DPeakQuickly(forArray: [] as [Int])



/*

*** Peak Finding in a 2D Array ***

Peak Definition:
	
for an array 
[[a,b,c,d],
 [e,f,g,h],
 [i,j,k,l]] where a...l are integers

if f >= b  AND f >= e AND f >= g AND f >= j then peak = f

Objective:
To find a peak for a 2-D array

*/

let array2D = [[10,11,12,13],
               [21,12,17,18],
               [12,16,28,21],
               [11,14,15,20]]


// Poor Performance Version - Quadratic
// Worst case complexity is Ø(n^2)

func find2DPeak<T: Integer>(inArray array: [[T]]) -> T {
	
	// Complete poor performance version of findPeak2D
	
	return -1
}


// Higher Performance Version - Linearithmic
// Worst case complexity is to Ø2(log^2(n))

func find2DPeakQuickly<T: Integer>(forArray array: [[T]]) -> T {

	if array.count == 1 {
		// Account for empty array of empty array
		if array[0].isEmpty {
			return -1
		} else {
			// Account for only 1 row or non-empty array
			return find1DPeakQuickly(forArray: array[0])
		}
	}
	
	// Find middle column index
	let m = array[0].count - 1 // columns
	let middleColumn = m/2
	
	// Assemble middle column as an array
	var middleColumnElements: [T] = []
	for array1D in array {
		let mValue = array1D[middleColumn]
		middleColumnElements.append(mValue)
	}
	
	// Find global max on middle column at (i, j)
	var maxM: T = -1
	var maxMRow: T = 0
	for (i, element) in middleColumnElements.enumerated() {
		if element >= maxM {
			maxM = element
			maxMRow = i as! T
		}
	}
	
	let peakRow = array[maxMRow as! Int]
	let ij = peakRow[middleColumn]
	
	if peakRow[middleColumn - 1] >= ij {
		// Take left slice of the array
		let leftSlice = peakRow[0...middleColumn - 1]
		return find1DPeakQuickly(forArray: Array(leftSlice))
	} else if peakRow[middleColumn + 1] >= ij {
		// Take right slice of the array
		let rightSlice = peakRow[middleColumn + 1...m]
		return find1DPeakQuickly(forArray: Array(rightSlice))
	} else {
		// As both (i,j-1) and (i, j+1) are less than (i,j) -> (i.j) is a peak
		return ij
	}
}

find2DPeakQuickly(forArray: array2D)

