//
//  BST.swift
//  Session5
//
//  Created by Lan on 17/3/4.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


class Node<Key, Value> {
    var key: Key
    var value: Value
    var left: Node? = nil
    var right: Node? = nil
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
    
    //即时计算所有的子节点数量(包括自己)
    var count: Int {
        var count = 1
        if let left = left { count += left.count }
        if let right = right { count += right.count }
        return count
    }
}

class BST<Key: Comparable, Value: Comparable> {
    
    typealias ElementNode = Node<Key, Value>
    typealias Element = (Key, Value)
    
    var root: ElementNode? = nil
    var size: Int {
        if root == nil { return 0 }
        return root!.count
    }
    
    var isEmpty: Bool {
        return size == 0
    }
    
    func insert(_ element: Element) {
        self.root = _insert(root, element)
    }
    
    func contain(_ key: Key) -> Bool {
        return _contain(root, key)
    }
    
    func search(_ key: Key) -> Value? {
        return _search(root, key)
    }
    
    //前序遍历
    func preOrder(_ behavior : (Element) -> Void) {
        _preOrder(root, behavior)
    }
    
    //中序遍历
    func inOrder(_ behavior : (Element) -> Void) {
        _inOrder(root, behavior)
    }
    
    //后序遍历
    func postOrder(_ behavior : (Element) -> Void) {
        _postOrder(root, behavior)
    }
    
    //层序遍历
    func levelOrder(_ behavior: (Element) -> Void) {
        _levelOrder(root, behavior)
    }
    
    func minimum() -> Key? {
        guard let root = root else {
            return nil
        }
        
        let node = _minimum(root)
        return node.key
    }
    
    func minimumWithoutRecursion() -> Key? {
        guard let root = root else {
            return nil
        }
        
        var leftNode = root
        while leftNode.left != nil {
            leftNode = leftNode.left!
        }
        
        return leftNode.key
    }
    
    func maximum() -> Key? {
        guard let root = root else {
            return nil
        }
        
        let node = _maximum(root)
        return node.key
    }
    
    func removeMin() {
        if root != nil {
            root = _removeMin(root!)
        }
    }
    
    func removeMax() {
        if root != nil {
            root = _removeMax(root!)
        }
    }
    
    func remove(_ key: Key) {
        root = _remove(root, key)
    }
    
    func floor(_ key: Key) -> Key? {
        return _floor(root, key)?.key
    }
    
    func ceil(_ key: Key) -> Key? {
        return _ceil(root, key)?.key
    }
    
    func rank(_ key: Key) -> Int? {
        var rank = 0
        var subNode = root
        while subNode != nil {
            
            if key < subNode!.key {
                subNode = subNode!.left
            } else if key > subNode!.key {
                if let left = subNode!.left {
                    rank += left.count
                }
                rank += 1
                subNode = subNode!.right
            } else {
                if let left = subNode!.left {
                    rank += left.count
                }
                rank += 1
                return rank
            }
        }
        
        return nil
    }
    
    func select(_ index: Int) -> Key? {
        
        var subNode: ElementNode? = root
        var smallerCount = 0
        
        while subNode != nil {
            let leftNodeCount = subNode?.left?.count ?? 0
            
            if smallerCount + leftNodeCount < index {
                smallerCount += leftNodeCount + 1 //往右找时需要把当前node加上所以+1
                subNode = subNode?.right
            } else if smallerCount + leftNodeCount > index {
                subNode = subNode?.left
            } else {
                return subNode!.key
            }
        }
        
        return nil
    }
    
}

extension BST {
    
    fileprivate func _contain(_ node: ElementNode?, _ key: Key) -> Bool {
        
        guard let node = node else {
            return false
        }
        
        if node.key == key {
            return true
        } else {
            let subNode = key < node.key ? node.left : node.right
            return _contain(subNode, key)
        }
    }
    
    fileprivate func _insert(_ node: ElementNode?, _ element: Element) -> ElementNode {
        guard let node = node else {
            return ElementNode(key: element.0, value: element.1)
        }
        
        if element.0 == node.key {
            node.value = element.1
        } else if element.0 < node.key {
            node.left = _insert(node.left, element)
        } else {
            node.right = _insert(node.right, element)
        }
        
        return node
    }
    
    fileprivate func _insertWithoutRecursion(_ node: ElementNode?, _ element: Element) -> ElementNode {
        guard let node = node else {
            return ElementNode(key: element.0, value: element.1)
        }
        
        var subNode: ElementNode? = node
        //找到需要插入Node的位置
        while subNode != nil {
            
            if node.key == element.0 {
                break
            } else {
                subNode = subNode!.key < element.0 ? subNode!.left : subNode!.right
            }
        }
        
        subNode = ElementNode(key: element.0, value: element.1)
        
        return node
    }
    
    fileprivate func _search(_ node: ElementNode?, _ key: Key) -> Value? {
        
        guard let node = node else {
            return nil
        }
        
        if node.key == key {
            return node.value
        } else {
            let subNode = key < node.key ? node.left : node.right
            return _search(subNode, key)
        }
    }
    
    fileprivate func _preOrder(_ node: ElementNode?, _ behavior: (Element) -> Void ) {
        
        if let node = node {
            behavior((node.key, node.value))
            _preOrder(node.left, behavior)
            _preOrder(node.right, behavior)
        }
    }
    
    fileprivate func _inOrder(_ node: ElementNode?, _ behavior: (Element) -> Void ) {
        
        if let node = node {
            _inOrder(node.left, behavior)
            behavior((node.key, node.value))
            _inOrder(node.right, behavior)
        }
    }
    
    fileprivate func _postOrder(_ node: ElementNode?, _ behavior: (Element) -> Void ) {
        
        if let node = node {
            _postOrder(node.left, behavior)
            _postOrder(node.right, behavior)
            behavior((node.key, node.value))
        }
    }
    
    
    fileprivate func _levelOrder(_ node: ElementNode?, _ behavior: (Element) -> Void) {
        
        var sequence = [node]
        while !sequence.isEmpty {
            
            let currentNode = sequence.removeFirst()!
            behavior((currentNode.key, currentNode.value))
            
            if let left = currentNode.left { sequence.append(left) }
            if let right = currentNode.right { sequence.append(right) }
        }
    }
    
    fileprivate func _minimum(_ node: ElementNode) -> ElementNode {
        
        if let left = node.left {
            return _minimum(left)
        } else {
            return node
        }
    }
    
    fileprivate func _maximum(_ node: ElementNode) -> ElementNode {
        
        if let right = node.right {
            return _maximum(right)
        } else {
            return node
        }
    }
    
    fileprivate func _removeMin(_ node: ElementNode) -> ElementNode? {
        
        if let left = node.left {
            node.left = _removeMin(left)
            return node
        }
        
        return node.right
    }
    
    fileprivate func _removeMax(_ node: ElementNode) -> ElementNode? {
        
        if let right = node.right {
            node.right = _removeMax(right)
            return node
        }
        
        return node.left
    }
    
    fileprivate func _remove(_ node: ElementNode?, _ key: Key) -> ElementNode? {
        guard let node = node else {
            return nil
        }
        
        if key < node.key {
            node.left = _remove(node.left, key)
        }
        
        if key > node.key {
            node.right = _remove(node.right, key)
        }
        
        if node.key == key {
            
            guard let leftNode = node.left else {
                return node.right
            }
            
            guard let rightNode = node.right else{
                return node.left
            }
            
            let successor = _minimum(rightNode)
            
            successor.left = leftNode
            successor.right = _removeMin(rightNode)
            
            return successor
        }
        
        return node
    }
    
    fileprivate func _searchNodeIn(_ node: ElementNode?, _ key: Key) -> ElementNode? {
        guard let node = node else {
            return nil
        }
        
        if key == node.key { return node }
        if key < node.key { return _searchNodeIn(node.left, key) }
        else { return _searchNodeIn(node.right, key) }
    }
    
    
    func _floor(_ node: ElementNode?, _ key: Key) -> ElementNode? {
        guard let node = node else {
            return nil
        }
        
        /*
         当node.key>key, 则从左子树找floor点, 如果没有则返回nil
         ps: 因为node.key大于key, 所以node本身不能作为结果返回
         */
        if node.key > key {
            return _floor(node.left, key)
        }
        
        /*
         当node.key<key, 则从右子树找floor点, 如果右子树没有合适的点则返回node
         ps: 因为node.key小于key, 所以当右子树没有更合适结果时, node本身已是最合适的结果
         */
        if node.key < key {
            return _floor(node.right, key) ?? node
        }
        
        return node
    }
    
    func _ceil(_ node: ElementNode?, _ key: Key) -> ElementNode? {
        guard let node = node else {
            return nil
        }
        
        if node.key < key {
            return _ceil(node.right, key)
        }
        
        if node.key > key {
            return _ceil(node.left, key) ?? node
        }
        
        return node
    }
    
    
}

