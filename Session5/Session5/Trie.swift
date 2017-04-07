//
//  Trie.swift
//  Session5
//
//  Created by Lan on 17/4/7.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

struct Trie<Element: Hashable> {
    let isElement: Bool
    let key: Element?
    let children: [Trie<Element>]
}


extension Trie {
    init() {
        isElement = false
        key = nil
        children = []
    }
}

