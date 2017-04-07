//
//  BinomialHeap.swift
//  Session4
//
//  Created by Lan on 17/3/13.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

/*
 二项堆
 */
class BinHeapNode<Key: Comparable> {
    var key: Key
    var degree: Int = 0
    var parent: BinHeapNode<Key>?
    var leftChild: BinHeapNode<Key>?
    var sibling: BinHeapNode<Key>?
    
    
    init(_ key: Key) {
        self.key = key
    }
    
}

