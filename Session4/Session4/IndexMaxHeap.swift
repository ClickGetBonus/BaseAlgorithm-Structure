//
//  IndexMaxHeap.swift
//  Session4
//
//  Created by Lan on 17/2/28.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


class IndexMaxHeap<Element: Comparable> {
    var indexes: [Int] = [Int]()
    var data: [Element] = [Element]()
    var reverse: [Int] = [Int]()
    var count: Int = 0
    let capacity: Int
    
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
    
    public func insert(_ x: Element, in i: Int) {
        assert(count < capacity, "Heap Full")
        assert(i+1>=1 && i+1<=capacity, "Index Out Of Range")
        
        data.append(x)
        indexes.append(i)
        reverse[i] = count
        count += 1
        shiftUp(count-1)
    }
    
    
    func extractMax() -> Element? {
        if count > 0 {
            if 0 != count-1{
                swap(&indexes[0], &indexes[count-1])
                reverse[indexes[0]] = 0
            }
            let ret = data.removeLast()
            indexes.removeLast()
            count -= 1
            shiftDown(0)
            return ret
        } else {
            print("extract nil value")
            return nil
        }
    }
    
    func extractMaxIndex() -> Int? {
        if count > 0 {
            if 0 != count-1{
                swap(&indexes[0], &indexes[count-1])
                reverse[indexes[0]] = 0
            }
            data.removeLast()
            let ret = indexes.removeLast()
            count -= 1
            shiftDown(0)
            return ret
        } else {
            print("extract nil value")
            return nil
        }
    }
    
    func getElement(_ i: Int) -> Element? {
        return data.count > i ? data[i] : nil
    }
    
    func change(_ newItem: Element, in i: Int) {
        assert(contain(i), "Change false")
        
        data[i] = newItem
        
        let j = reverse[i]
        shiftUp(j)
        shiftDown(j)
    }
    
    func contain(_ i: Int) -> Bool {
        assert(i>=0 && i < capacity, "Did Not Contain Index")
        return reverse[i] != 0
    }
    
    internal func shiftDown(_ k: Int) {
        var k = k
        while 2*k < count {
            var j = 2*k
            if j+1 < count && data[indexes[j+1]] > data[indexes[j]] {
                j += 1
            }
            if data[indexes[k]] >= data[indexes[j]] {
                break
            }
            
            if j != k {
                swap(&indexes[k], &indexes[j])
                reverse[indexes[k]] = k
                reverse[indexes[j]] = j
            }
            
            k = j
        }
    }
    
    internal func shiftUp(_ k: Int) {
        var k = k
        while k>0 && data[indexes[k/2]] < data[indexes[k]] {
            if k/2 != k {
                swap(&indexes[k/2], &indexes[k])
                reverse[indexes[k/2]] = k/2
                reverse[indexes[k]] = k
                k /= 2
            }
        }
    }
}
