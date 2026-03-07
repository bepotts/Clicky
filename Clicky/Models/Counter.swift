//
//  Counter.swift
//  Clicky
//
//  Created by Brandon Potts on 3/4/26.
//

import Foundation
import SwiftData

@Model
final class Counter {
    var count: Int
    var name: String
    var incrementBy: Int

    init(count: Int = 0, name: String = "", incrementBy: Int = 1) {
        self.count = count
        self.name = name
        self.incrementBy = incrementBy
    }

    func increment() {
        count += incrementBy
    }

    func decrement() {
        count -= incrementBy
        if count < 0 {
            count = 0
        }
    }
}
