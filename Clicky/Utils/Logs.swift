//
//  Logs.swift
//  Clicky
//
//  Created by Brandon Potts on 3/7/26.
//

import os

extension Logger {
    static let users: Logger = .init(subsystem: AppStrings.bundle, category: "users")
}
