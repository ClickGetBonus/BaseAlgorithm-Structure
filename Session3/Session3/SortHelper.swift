//
//  SortHelper.swift
//  Session3
//
//  Created by Lan on 17/2/20.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


/*
 生成测试用例
 */
func generateRandomArray(count: Int, rangeL: Int, rangeR: Int) -> [Int] {
    var result = [Int]()
    for _ in 0 ..< count {
        let value = Int(arc4random()%(UInt32(rangeR - rangeL))) + rangeL
        result.append(value)
    }
    return result
}

/*
 测试算法的性能
 */
func testSort<T: Comparable>(_ sort: ([T]) -> [T], array: [T]) -> Float{
    let start = CFAbsoluteTimeGetCurrent()
    let arr = sort(array)
    let usingTime = CFAbsoluteTimeGetCurrent()-start
    
    if isSorted(arr) == false {
        print("Sort false")
        print("False Array: \(array)")
    }
    
    return Float(usingTime)
}

func isSorted<T: Comparable>(_ array: [T]) -> Bool {
    for i in 0 ..< array.count-1 {
        if array[i] > array[i+1] {
            return false
        }
    }
    return true
}

//生成部分有序的数组
func generateNearlyOrderedArray(count: Int, swapTimes: Int) -> [Int] {
    var result = [Int]()
    for i in 0 ..< count {
        result.append(i)
    }
    let swapTimes = swapTimes < count ? swapTimes : count-1
    
    for _ in 0 ..< swapTimes {
        let posx = Int(arc4random()%UInt32(swapTimes))
        let posy = Int(arc4random()%UInt32(swapTimes))
        if posx != posy {
            swap(&result[posx], &result[posy])
        }
    }
    
    return result
}


