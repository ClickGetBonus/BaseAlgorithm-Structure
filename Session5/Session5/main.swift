//
//  main.swift
//  Session5
//
//  Created by Lan on 17/3/1.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

enum SearchResult: Error {
    case success(Int)
    case fail
}

/*
 5-1 二分查找法
 */

func binarySearch<T: Comparable>(_ xs: [T], target: T) -> Int? {
    var l = 0
    var r = xs.count-1
    while l <= r {
        let mid = l + (r-l)/2
        
        if xs[mid] == target {
            return mid
        } else if xs[mid] > target {
            r = mid - 1
        } else {
            l = mid + 1
        }
        
    }
    
    return nil
}


let nearlyArr = generateNearlyOrderedArray(count: 50000000, swapTimes: 0)
//print("Binary Search NearlyArr Using Time: \(testSearch(binarySearch, array: nearlyArr, target: 345))")

//递归
func binarySearchWithRecursion<T: Comparable>(_ xs: [T], target: T) -> Int? {
    return _binarySearchWithRecursion(xs, target: target, l: 0, r: xs.count-1)
}

func _binarySearchWithRecursion<T: Comparable>(_ xs: [T], target: T, l: Int, r: Int) -> Int? {
    let mid = l + (r-l)/2
    if l >= r {
        return nil
    }
    
    if xs[mid] == target {
        return mid
    } else if xs[mid] > target {
        return _binarySearchWithRecursion(xs, target: target, l: l, r: mid-1)
    } else {
        return _binarySearchWithRecursion(xs, target: target, l: mid+1, r: r)
    }
}

//print("BinaryWithRecursion Search NearlyArr Using Time: \(testSearch(binarySearchWithRecursion, array: nearlyArr, target: 345))")




/*
 二分搜索树
 */
var strBst = BST<String, Int>()

//从圣经中提取每个单词插入二分搜索树
var array = bible.components(separatedBy: CharacterSet(charactersIn: " ,\"\"''.!;:?"))
bible.enumerateSubstrings(in: bible.startIndex..<bible.endIndex , options: .byWords) { (subString, _, _, _) in
    
    guard let subString = subString else {
        return
    }
    
    if let value: Int = strBst.search(subString) {
        strBst.insert((subString, value+1))
    } else {
        strBst.insert((subString, 1))
    }
}

let result = strBst.search("God")
print(result ?? "Can't Found")




let intBst = BST<Int, Int>()
var testArray = [41, 22, 15, 13, 33, 37, 58, 63, 50, 42, 53]

let _ = testArray.map {
    if let value: Int = intBst.search($0) {
        intBst.insert(($0, value+1))
    } else {
        intBst.insert(($0, 1))
    }
}

//前中后序遍历
//intBst.preOrder { print($0.0) }
//intBst.inOrder { print($0.0) }
//intBst.postOrder { print($0.0) }

//层序遍历
//intBst.levelOrder { print($0.0) }

//最大最小值
//print(intBst.minimum()!)
//print(intBst.maximum()!)


//intBst.remove(15)
//print(intBst.search(15) ?? "Search Not Found")


print(intBst.floor(12) ?? "Floor Not Found")
print(intBst.ceil(64) ?? "Ceil Not Found")
print(intBst.select(5) ?? "Select Not Found")


/*
 5-11 trie实现
 */



