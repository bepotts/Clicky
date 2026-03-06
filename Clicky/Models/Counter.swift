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

    init(count: Int = 0, name: String = "") {
        self.count = count
        self.name = name
    }
}
