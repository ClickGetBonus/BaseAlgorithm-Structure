//
//  main.swift
//  Session3
//
//  Created by Lan on 17/2/20.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


let testArray = generateRandomArray(count: 5000, rangeL: 0, rangeR: 10)
let nearlyArray = generateNearlyOrderedArray(count: 5000, swapTimes: 10)


/*
 3-2 归并排序
 */
func mergeSorted<T: Comparable>(_ arr: [T]) -> [T]{
    var result = arr
    mergeSort(&result, l: arr.startIndex, r: arr.endIndex-1)
    return result
}


func mergeSort<T: Comparable>(_ arr: inout [T], l: Int, r: Int){
    if l >= r {
        return
    }
    
    let mid = (l+r)/2
    mergeSort(&arr, l: l, r: mid)
    mergeSort(&arr, l: mid+1, r: r)
    merge(&arr, l: l, mid: mid, r: r)
}

func merge<T: Comparable>(_ arr: inout [T], l: Int, mid: Int, r: Int) {
    let aux = arr
    
    var i = l
    var j = mid + 1
    
    for k in l ... r {
        
        if i > mid {
            arr[k] = aux[j-l]
            j += 1
        } else if j > r {
            arr[k] = aux[i-l]
            i += 1
        } else if aux[i-l] <= aux[j-l] {
            arr[k] = aux[i-l]
            i += 1
        } else {
            arr[k] = aux[j-l]
            j += 1
        }
    }
}


//print(mergeSorted(testArray))
//print("Merge Sort testArray Using Time: \(testSort(mergeSorted, array: testArray))")
//print("Merge Sort nearlyArray Using Time: \(testSort(mergeSorted, array: nearlyArray))")
//
//print("Insection Sort testArray Using Time: \(testSort(insertionSort, array: testArray))")
//print("Insection Sort nearlyArray Using Time: \(testSort(insertionSort, array: nearlyArray))")


/*
 3-3 归并排序法的优化
 */
func mergeSorted2<T: Comparable>(_ arr: [T]) -> [T]{
    var result = arr
    mergeSort2(&result, l: arr.startIndex, r: arr.endIndex-1)
    return result
}


func mergeSort2<T: Comparable>(_ arr: inout [T], l: Int, r: Int){
    let mid = (l+r)/2
    
    if r - l <= 15 {
        arr[l...r] = ArraySlice(insertionSort(Array(arr[l...r])))
        return
    }
    
    mergeSort2(&arr, l: l, r: mid)
    mergeSort2(&arr, l: mid+1, r: r)
    if arr[mid] > arr[mid+1] {
        merge(&arr, l: l, mid: mid, r: r)
    }
}


//print("Merge2 Sort testArray Using Time: \(testSort(mergeSorted2, array: testArray))")
//print("Merge2 Sort nearlyArray Using Time: \(testSort(mergeSorted2, array: nearlyArray))")

/*
 3-4 自底向上的归并排序
 */

func mergeSortBU<T: Comparable>(_ arr: [T]) -> [T] {
    var result = arr
    
    var sz = 1
    while sz <= arr.count {
        
        for i in stride(from: 0, to: arr.count, by: 2*sz) {
            merge(&result, l: i, mid: i+sz-1, r: min(i+2*sz-1, arr.count-1))
        }
        
        sz += sz
    }
    
    return result
}


print("MergeBU Sort testArray Using Time: \(testSort(mergeSortBU, array: testArray))")
print("MergeBU Sort nearlyArray Using Time: \(testSort(mergeSortBU, array: nearlyArray))")

//优化
func mergeSortBU2<T: Comparable>(_ arr: [T]) -> [T] {
    var result = arr
    
    var sz = 1
    while sz <= arr.count {
        
        for i in stride(from: 0, to: arr.count, by: 2*sz) {
            let mid = i+sz-1
            let r = min(i+2*sz-1, arr.count-1)
            
            if mid+1 < arr.count {
                
                if result[mid] < result[mid+1] {
                    continue
                }
                
                if sz <= 15 {
                    result[i...r] = ArraySlice(insertionSort(Array(result[i...r])))
                    continue
                }
                
                merge(&result, l: i, mid: i+sz-1, r: min(i+2*sz-1, arr.count-1))
            }
        }
        
        sz += sz
    }
    
    return result
}


//print("MergeBU2 Sort testArray Using Time: \(testSort(mergeSortBU2, array: testArray))")
//print("MergeBU2 Sort nearlyArray Using Time: \(testSort(mergeSortBU2, array: nearlyArray))")



/*
 3-5 快速排序
 */
func quickSorted<T: Comparable>(_ arr: [T]) -> [T] {
    if arr.count <= 1 {
        return arr
    }
    
    
    var result = arr
    let j = partition(&result)
    
    if j > 1 {
        result[0...j-1] = ArraySlice(quickSorted(Array(result[0...j-1])))
    }
    if j+1 < result.count {
        result[j+1...result.endIndex-1] = ArraySlice(quickSorted(Array(result[j+1...result.endIndex-1])))
    }
    return result
}

func partition<T: Comparable>(_ arr: inout [T]) -> Int {
    
    
    let l = arr[0]
    var j = 0
    
    for i in 1 ..< arr.count {
        
        if arr[i] < l {
            if j+1 != i {
                swap(&arr[j+1], &arr[i])
            }
            j += 1
        }
    }
    
    if j != 0 {
        swap(&arr[0], &arr[j])
    }
    
    
    return j
}


//print("Quick Sort testArray Using Time: \(testSort(quickSorted, array: testArray))")
//print("Quick Sort nearlyArray Using Time: \(testSort(quickSorted, array: nearlyArray))")

//快速排序优化
func quickSorted2<T: Comparable>(_ arr: [T]) -> [T] {
    
    
    if arr.count <= 1 {
        return arr
    }
    
    if arr.count < 16 {
        return insertionSort(arr)
    }
    
    var result = arr
    let j = partition2(&result)
    
    if j > 1 {
        result[0...j-1] = ArraySlice(quickSorted2(Array(result[0...j-1])))
    }
    if j+1 < result.count {
        result[j+1...result.endIndex-1] = ArraySlice(quickSorted2(Array(result[j+1...result.endIndex-1])))
    }
    return result
}

func partition2<T: Comparable>(_ arr: inout [T]) -> Int {
    
    
    let randomValue = Int(arc4random()%UInt32(arr.count))
    if randomValue != 0 {
        swap(&arr[0], &arr[randomValue])
    }
    let l = arr[0]
    var j = 0
    
    for i in 1 ..< arr.count {
        
        if arr[i] < l {
            if j+1 != i {
                swap(&arr[j+1], &arr[i])
            }
            j += 1
        }
    }
    
    if j != 0 {
        swap(&arr[0], &arr[j])
    }
    
    return j
}



//print("Quick2 Sort testArray Using Time: \(testSort(quickSorted2, array: testArray))")
//print("Quick2 Sort nearlyArray Using Time: \(testSort(quickSorted2, array: nearlyArray))")


/*
 3-7 双路快速排序法
 */
func quickSortedTwoWays<T: Comparable>(_ arr: [T]) -> [T] {
    
    if arr.count <= 1 {
        return arr
    }
    
    if arr.count < 16 {
        return insertionSort(arr)
    }
    
    var result = arr
    let j = partitionTwoWays(&result)
    
    if j > 1 {
        result[0...j-1] = ArraySlice(quickSortedTwoWays(Array(result[0...j-1])))
    }
    if j+1 < result.count {
        result[j+1...result.endIndex-1] = ArraySlice(quickSortedTwoWays(Array(result[j+1...result.endIndex-1])))
    }
    return result
}

func partitionTwoWays<T: Comparable>(_ arr: inout [T]) -> Int {
    
    let randomValue = Int(arc4random()%UInt32(arr.count))
    if randomValue != 0 {
        swap(&arr[0], &arr[randomValue])
    }
    let l = arr[0]
    var j = arr.count-1
    var i = 1
    
    while true {
        
        while i < arr.count-1 && arr[i] <= l {
            i += 1
        }
        
        while j > 0 && arr[j] >= l  {
            j -= 1
        }
        
        if i >= j {
            break
        }
        
        if i != j {
            swap(&arr[i], &arr[j])
        }
        
        i += 1
        j -= 1
    }
    
    
    if j != 0 {
        swap(&arr[0], &arr[j])
    }
    
    return j
}

//print("QuickTwoWays Sort testArray Using Time: \(testSort(quickSortedTwoWays, array: testArray))")
//print("QuickTwoWays Sort nearlyArray Using Time: \(testSort(quickSortedTwoWays, array: nearlyArray))")


/*
 3-8 三路快速排序
 */
func quickSortThreeWays<T: Comparable>(_ arr: [T]) -> [T] {
    
    
    if arr.count <= 1 {
        return arr
    }
    
    if arr.count < 16 {
        return insertionSort(arr)
    }
    
    var result = arr
    let (lt, rt) = partitionThreeWays(&result)
    
    if lt > 1 {
        result[0...lt] = ArraySlice(quickSortThreeWays(Array(result[0...lt])))
    }
    if rt+1 < result.count {
        result[rt...result.endIndex-1] = ArraySlice(quickSortThreeWays(Array(result[rt...result.endIndex-1])))
    }
    return result
}

//返回左右边界
func partitionThreeWays<T: Comparable>(_ arr: inout [T]) -> (Int, Int) {
    
    let randomValue = Int(arc4random()%UInt32(arr.count))
    if randomValue != 0 {
        swap(&arr[0], &arr[randomValue])
    }
    let l = arr[0]
    var i = 1
    var lt = 0
    var rt = arr.count
    
    while i < rt {
        
        if arr[i] > l {
            rt -= 1
            if i != rt {
                swap(&arr[i], &arr[rt])
            }
        } else if arr[i] < l {
            if  i != lt+1 {
                swap(&arr[i], &arr[lt+1])
            }
            lt += 1
            i += 1
        } else {
            
            i += 1
        }
        
    }
    
    if lt != 0 {
        swap(&arr[lt], &arr[0])
    }
    
    return (lt, rt)
}


print("QuickThreeWays Sort testArray Using Time: \(testSort(quickSortThreeWays, array: testArray))")
print("QuickThreeWays Sort nearlyArray Using Time: \(testSort(quickSortThreeWays, array: nearlyArray))")


/*
 3-9 使用归并获取数组的逆序对数
 */
func calInversionCount<T: Comparable>(in arr: [T]) -> [T] {
    
    var resultArray = arr
    var inversionCount = 0
    var stepSize = 1
    
    while stepSize < arr.count {
        
        for i in 0 ... arr.count/(2*stepSize) {
            
            
            let left = min(i*(stepSize*2), resultArray.count-1)
            let mid = min(left+stepSize-1, resultArray.count-1)
            let right = min(left+2*stepSize-1, resultArray.count-1)
            
            var stepArray = [T]()
            
            
            var lArr = Array(resultArray[left...mid])
            
            
            var rArr = [T]()
            
            
            if  stepSize + left < arr.count {
                rArr = Array(resultArray[mid+1...right])
            }
            var l = 0
            var r = 0
            
            while stepArray.count < 2*stepSize && stepArray.count + left < arr.count {
                
                if r >= rArr.count &&  l < lArr.count{
                    stepArray.append(lArr[l])
                    l += 1
                } else if l >= lArr.count {
                    stepArray.append(rArr[r])
                    r += 1
                } else if lArr[l] < rArr[r] {
                    stepArray.append(lArr[l])
                    l += 1
                    
                } else if rArr[r] < lArr[l]{
                    stepArray.append(rArr[r])
                    r += 1
                } else {
                    stepArray.append(rArr[r])
                    r += 1
                }
                
            }
            
            resultArray[left...right] = ArraySlice(stepArray)
            inversionCount = 1
        }
        
        
        stepSize += stepSize
    }
    
    return resultArray
}



//let (inverArray, inversionCount) = calInversionCount(in: testArray)
//print(inverArray)
//print(inversionCount)

print("MergeBU2 Sort testArray Using Time: \(testSort(calInversionCount, array: testArray))")
print("MergeBU2 Sort nearlyArray Using Time: \(testSort(calInversionCount, array: nearlyArray))")

/*
 4-8 索引堆
 */

