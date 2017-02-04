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

func findPeak<T: Integer>(forArray array: [T]) -> T {
	
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

findPeak(forArray: array)


// Higher Performance Version - Logarithmic
// Here we use binary search/divide and conquer technique to improve the algorithms' performance to Ø(log^2(n))

func findPeakQuickly<T: Integer>(forArray array: [T]) -> T {
	
	let n = array.count - 1
	let middleIndex = n/2
	
	if middleIndex == 0 {
		return array[middleIndex]
	} else if array[middleIndex] <= array[middleIndex - 1] {
		// Take left slice of the array
		let leftArray = array[0...middleIndex-1]
		return findPeakQuickly(forArray: Array(leftArray))
	} else if array[middleIndex] <= array[middleIndex + 1] {
		// Take right slice of the array
		let rightArray = array[middleIndex+1...n]
		return findPeakQuickly(forArray:  Array(rightArray))
	} else {
		return array[middleIndex]
	}
}

