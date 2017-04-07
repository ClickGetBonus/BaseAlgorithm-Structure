//
//  main.swift
//  Session4
//
//  Created by Lan on 17/2/27.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

/*
 4-5 基础堆排序
 */
func heapSorted1<T: Comparable>(_ xs: [T]) -> [T] {
    var result = xs
    let maxHeap = MaxHeap<T>(capacity: xs.count)
    
    for i in stride(from: 0, to: result.count, by: 1) {
        maxHeap.insert(result[i])
    }
    
    for i in stride(from: xs.count-1, through: 0, by: -1) {
        result[i] = maxHeap.extractMax()!
    }
    return result
}


let maxHeap = MaxHeap<Int>(capacity: 15)

var heapTestArray = generateRandomArray(count: 15, rangeL: 0, rangeR: 100)

print(heapTestArray)
for i in heapTestArray {
    maxHeap.insert(i)
}
testPrint(maxHeap.data)


func heapSorted2<T: Comparable>(_ xs: [T]) -> [T] {
    var result: [T] = xs
    let heap = MaxHeap(xs)
    
    for i in stride(from: heap.count-1, through: 0, by: -1) {
        result[i] = heap.extractMax()!
    }
    
    return result
}

func heapSorted<T: Comparable>(_ xs: [T]) -> [T] {
    var result = xs
    
    //heapify
    for i in stride(from: (xs.count-1)/2, through: 0, by: -1) {
        shiftDown(&result, result.count, i)
    }
    
    for i in stride(from: xs.count-1, to: 0, by: -1) {
        if i != 0 {
            swap(&result[i], &result[0])
        }
        shiftDown(&result, i, 0)
    }
    
    return result
}


func shiftDown<T: Comparable>(_ xs: inout [T], _ r: Int, _ k: Int) {
    var k = k
    while 2*k < r {
        var j = 2*k
        if j+1 < r && xs[j+1] > xs[j] {
            j += 1
        }
        if xs[k] >= xs[j] {
            break
        }
        
        if j != k {
            swap(&xs[k], &xs[j])
        }
        
        k = j
    }
}


let testArray = generateRandomArray(count: 5000, rangeL: 0, rangeR: 1000)
let nearlyArray = generateNearlyOrderedArray(count: 5000, swapTimes: 10)
let equalArray = generateRandomArray(count: 5000, rangeL: 0, rangeR: 10)

//print("Quick Sort testArray Using Time: \(testSort(quickSorted, array: testArray))")
//print("QuickThreeWays Sort testArray Using Time: \(testSort(quickSortThreeWays, array: testArray))")
//print("Merge Sort testArray Using Time: \(testSort(mergeSorted, array: testArray))")
//print("Heap1 Sort testArray Using Time: \(testSort(heapSorted1, array: testArray))")
//print("Heap2 Sort testArray Using Time: \(testSort(heapSorted2, array: testArray))")
//print("Heap3 Sort testArray Using Time: \(testSort(heapSorted, array: testArray))")
//print("\n")

//print("Quick Sort nearlyArray Using Time: \(testSort(quickSorted, array: nearlyArray))")
//print("QuickThreeWays Sort nearlyArray Using Time: \(testSort(quickSortThreeWays, array: nearlyArray))")
//print("Merge Sort nearlyArray Using Time: \(testSort(mergeSorted, array: nearlyArray))")
//print("Heap1 Sort nearlyArray Using Time: \(testSort(heapSorted1, array: nearlyArray))")
//print("Heap2 Sort nearlyArray Using Time: \(testSort(heapSorted2, array: nearlyArray))")
//print("Heap3 Sort nearlyArray Using Time: \(testSort(heapSorted, array: nearlyArray))")
//
//print("\n")

//print("Quick Sort equalArray Using Time: \(testSort(quickSorted, array: equalArray))")
//print("QuickThreeWays Sort equalArray Using Time: \(testSort(quickSortThreeWays, array: equalArray))")
//print("Merge Sort equalArray Using Time: \(testSort(mergeSorted, array: equalArray))")
//print("Heap1 Sort equalArray Using Time: \(testSort(heapSorted1, array: equalArray))")
//print("Heap2 Sort equalArray Using Time: \(testSort(heapSorted2, array: equalArray))")
//print("Heap3 Sort equalArray Using Time: \(testSort(heapSorted, array: equalArray))")
//print("\n")








