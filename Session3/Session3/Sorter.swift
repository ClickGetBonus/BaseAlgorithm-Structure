//
//  Sorter.swift
//  Session3
//
//  Created by Lan on 17/2/20.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

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
