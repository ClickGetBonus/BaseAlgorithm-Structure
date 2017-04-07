//
//  main.swift
//  Session2
//
//  Created by Lan on 17/2/18.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation



//测试数据
let intArray: [Int] = [1, 6, 2, 3, 8, 5, 7, 4, 9]
let floatArray = [1.5, 2.5, 3.2, 0.5, 3.2, 7.4]
let charArray = ["B", "A", "D", "C"]

/*
 2-1 选择排序算法
 */
func selectionIntSort( _ array: [Int]) -> [Int] {
    
    var minIndex = 0
    var result: [Int] = array
    
    for i in 0 ..< array.count {
        minIndex = i
        for j in i+1 ..< array.count {
            if result[j] < result[minIndex] {
                minIndex = j
            }
        }
        
        if (i != minIndex) {
            swap(&result[i], &result[minIndex])
        }
    }
    
    return result
}

//print(selectionIntSort(intArray))

/*
 2-2 为选择排序方法添加泛型
 */
func selectionSort<A: Comparable>( _ arr: [A]) -> [A] {
    
    var minIndex = 0
    var result: [A] = arr
    
    for i in 0 ..< arr.count {
        minIndex = i
        for j in i+1 ..< result.count {
            if result[j] < result[minIndex] {
                minIndex = j
            }
        }
        
        if (i != minIndex) {
            swap(&result[i], &result[minIndex])
        }
    }
    
    return result
}

//print(selectionSort(floatArray))
//print(selectionSort(charArray))



//通过重载运算符来为实体排序
struct Student : Comparable{
    let name: String
    let score: Int
    
    static func <(lhs: Student, rhs: Student) -> Bool{
        
        return lhs.score == rhs.score ? lhs.name < rhs.name : lhs.score < rhs.score
    }
    
    static func ==(lhs: Student, rhs: Student) -> Bool {
        return lhs.score == rhs.score
    }
    
    
    static func >(lhs: Student, rhs: Student) -> Bool{
        return lhs.score == rhs.score ? lhs.name > rhs.name : lhs.score > rhs.score
    }
}

let students = [Student(name: "B", score: 84),
                Student(name: "A", score: 55),
                Student(name: "D", score: 55),
                Student(name: "C", score: 95)]

//print(selectionSort(students))


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

let testArray = generateRandomArray(count: 10000, rangeL: 0, rangeR: 1000)


func isSorted<T: Comparable>(_ array: [T]) -> Bool {
    for i in 0 ..< array.count-1 {
        if array[i] > array[i+1] {
            return false
        }
    }
    return true
}

/*
 2-4 测试算法的性能
 */
func testSort<T: Comparable>(_ sort: ([T]) -> [T], array: [T]) -> Float{
    let current = NSDate().timeIntervalSince1970
    let arr = sort(array)
    let usingTime = NSDate().timeIntervalSince1970 - current
    if isSorted(arr) == false {
        print("Sort false")
    }
    
    return Float(usingTime)
}


//print("selection Sort testArray Using Time : \(testSort(selectionSort, array: testArray))")


/*
 2-5 插入排序算法
 */
func insertionSort<T: Comparable>(_ arr: [T]) -> [T] {
    var result = arr
    for i in 1 ..< arr.count {
        
        for j in stride(from: i, through:1, by: -1) {
            if result[j] < result[j-1] {
                swap(&result[j], &result[j-1])
            } else {
                break
            }
        }
    }
    
    return result
}


//print("Insertion Sort testArray Using Time : \(testSort(insertionSort, array: testArray))")


/*
 2.6 插入排序的改进
 */
func insertionSort2<T: Comparable>(_ arr: [T]) -> [T] {
    var result = arr
    for i in 1 ..< arr.count {
        
        let insertValue = arr[i]
        //当需要插入的数比前一个数大, 说明该数已经在正确的位置, 直接进行下一次循环
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

//print("Insertion2 Sort testArray Using Time : \(testSort(insertionSort2, array: testArray))")


//生成部分有序的数组
func generateNearlyOrderedArray(count: Int, swapTimes: Int) -> [Int] {
    var result = [Int]()
    for i in 0 ..< count {
        result.append(i)
    }
    
    for _ in 0 ..< swapTimes {
        let posx = Int(arc4random()%UInt32(swapTimes))
        let posy = Int(arc4random()%UInt32(swapTimes))
        if posx != posy {
            swap(&result[posx], &result[posy])
        }
    }
    
    return result
}

let nearlyArray = generateNearlyOrderedArray(count: 10000, swapTimes: 500)


//print("selection Sort NearlyArray Using Time : \(testSort(selectionSort, array: nearlyArray))")
//print("Insertion Sort NearlyArray Using Time : \(testSort(insertionSort, array: nearlyArray))")
//print("Insertion2 Sort NearlyArray Using Time : \(testSort(insertionSort2, array: nearlyArray))")





/*
 以下为冒泡排序和希尔排序的范例
 */
func bubbleSort<T: Comparable>(_ arr: [T]) -> [T] {
    var result = arr
    for i in 0 ..< arr.count {
        
        for j in i+1 ..< arr.count {
            
            if result[j] < result[i] {
                swap(&result[j], &result[i])
            }
        }
    }
    
    return result
}

//print(bubbleSort(testArray))
//print("Bubble Sort TestArray Using Time : \(testSort(bubbleSort, array: testArray))")
//print("Bubble Sort NearlyArray Using Time : \(testSort(bubbleSort, array: nearlyArray))")


//希尔排序
func shellSort<T: Comparable>(_ arr: [T]) -> [T] {
    var result = arr
    var stepSize: Int = arr.count/2
    while stepSize > 0 {
        
        for i in 1 ..< Int(arr.count/stepSize) {
            
            let sortIndex = i*stepSize
            let insertValue = result[sortIndex]
            var j = sortIndex
            while j>0 && insertValue < result[j-stepSize] {
                result[j] = result[j-stepSize]
                j -= stepSize
            }
            result[j] = insertValue
        }
        
        
        stepSize /= 2
    }
    
    return result
}

//print(shellSort(testArray))
//print("Shell Sort TestArray Using Time : \(testSort(shellSort, array: testArray))")
//print("Shell Sort NearlyArray Using Time : \(testSort(shellSort, array: nearlyArray))")
