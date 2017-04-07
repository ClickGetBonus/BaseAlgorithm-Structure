//
//  Heap.swift
//  Session4
//
//  Created by Lan on 17/2/27.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


class MaxHeap<Element: Comparable> {
    var data: [Element] = [Element]()
    var count: Int = 0
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    init(_ xs: [Element]) {
        capacity = xs.count
        data = xs
        count = xs.count
        
        for i in stride(from: count/2, to: 0, by: -1) {
            shiftDown(i-1)
        }
    }
    
    func size() -> Int {
        return count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func insert(_ x: Element) {
        assert(count < capacity, "Heap Full")
        if count < capacity {
            
            data.append(x)
            count += 1
            shiftUp(count-1)
        } else {
            print("Heap full")
        }
    }
    
    func extractMax() -> Element? {
        if count > 0 {
            if 0 != count-1{
                swap(&data[0], &data[count-1])
            }
            let ret = data.removeLast()
            count -= 1
            shiftDown(0)
            return ret
        } else {
            print("extract nil value")
            return nil
        }
    }
    
    private func shiftDown(_ k: Int) {
        var k = k
        while 2*k < count {
            var j = 2*k
            if j+1 < count && data[j+1] > data[j] {
                j += 1
            }
            if data[k] >= data[j] {
                break
            }
            
            if j != k {
                swap(&data[k], &data[j])
            }
            
            k = j
        }
    }
    
    private func shiftUp(_ k: Int) {
        var k = k
        while k>0 && data[k/2] < data[k] {
            if k/2 != k {
                swap(&data[k/2], &data[k])
                k /= 2
            }
        }
    }
}

func testPrint(_ xs: [Int]) {
    var k = 1
    var i = 0
    while i < xs.count-2 {
        
        let r = min(k+i, xs.count)
        print(Array(xs[i...r-1]))
        print("\n")
        
        i += k
        k *= 2
    }
}
