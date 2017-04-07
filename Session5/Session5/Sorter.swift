//
//  Sorter.swift
//  Session3
//
//  Created by Lan on 17/2/20.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

/*
 插入排序
 */
func insertionSort<T: Comparable>(_ arr: [T]) -> [T] {
    var result = arr
    for i in 1 ..< arr.count {
        
        let insertValue = arr[i]
        if (insertValue >= result[i-1]) {
            continue
        }
        
        for j in stride(from: i, through: 0, by: -1) {
            if j == 0 || insertValue > result[j-1] {
                result[j] = insertValue
                break
            } else {
                result[j] = result[j-1]
            }
        }
    }
    
    return result
}


/*
 归并排序法
 */
func mergeSorted<T: Comparable>(_ arr: [T]) -> [T]{
    var result = arr
    mergeSort(&result, l: arr.startIndex, r: arr.endIndex-1)
    return result
}


func mergeSort<T: Comparable>(_ arr: inout [T], l: Int, r: Int){
    let mid = (l+r)/2
    
    if r - l <= 15 {
        arr[l...r] = ArraySlice(insertionSort(Array(arr[l...r])))
        return
    }
    
    mergeSort(&arr, l: l, r: mid)
    mergeSort(&arr, l: mid+1, r: r)
    if arr[mid] > arr[mid+1] {
        merge(&arr, l: l, mid: mid, r: r)
    }
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

/*
 快速排序
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


/*
 三路快速排序
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
