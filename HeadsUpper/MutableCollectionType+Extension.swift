//
//  MutableCollectionType+Extension.swift
//  HeadsUpper
//
//  Created by Jovanny Espinal on 2/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
