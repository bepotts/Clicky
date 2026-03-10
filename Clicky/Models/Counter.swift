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
    @Attribute(.unique) var id: UUID
    var count: Int
    var name: String
    var incrementBy: Int

    init(id: UUID = UUID(), count: Int = 0, name: String, incrementBy: Int = 1) {
        precondition(!name.isEmpty, "Counter name must not be empty")
        self.id = id
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
