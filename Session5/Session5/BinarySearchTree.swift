//
//  BinarySearchTree.swift
//  Session5
//
//  Created by Lan on 17/3/6.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

/*
 使用递归枚举来实现二叉搜索树
 */

indirect enum BinarySearchTree<Key: Comparable, Value: Comparable> {
    typealias Element = (Key, Value)
    typealias ElementTree = BinarySearchTree<Key, Value>
    
    case leaf
    case node(ElementTree, Element, ElementTree)
}

extension BinarySearchTree {
    
    init() {
        self = .leaf
    }
    
    init(_ element: Element) {
        self = .node(.leaf, element, .leaf)
    }
}

extension BinarySearchTree {
    
    var count: Int {
        switch self {
        case .leaf:
            return 0
        case let .node(leftTree, _, rightTree):
            return 1 + leftTree.count + rightTree.count
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .leaf:
            return true
        default:
            return false
        }
    }
    
    //由于枚举是值类型, 所以插入操作并不是更改key对应的值, 而是整个tree变量
    mutating func insert(_ element: Element) {
        switch self {
        case .leaf:
            self = ElementTree.node(.leaf, element, .leaf)
        case .node(var left, let (k, v), var right):
            
            if element.0 == k {
                self = .node(left, element, right)
                break
            }
            
            if element.0 < k { left.insert(element) }
            if element.0 > k { right.insert(element) }
            
            self = .node(left, (k, v), right)
        }
    }
    
    func contain(_ key: Key) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(leftTree, (k, _), rightTree):
            if key == k { return true }
            else if key < k { return leftTree.contain(key) }
            else { return rightTree.contain(key) }
        }
    }
    
    func search(_ key: Key) -> Value? {
        switch self {
        case .leaf:
            return nil
        case let .node(leftTree, (k, v), rightTree):
            if key == k { return v }
            else if key < k { return leftTree.search(key) }
            else { return rightTree.search(key) }
        }
    }
}
