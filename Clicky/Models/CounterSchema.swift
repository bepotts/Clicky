//
//  CounterSchema.swift
//  Clicky
//
//  Created by Brandon Potts on 3/13/26.
//

import SwiftData

enum CounterSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] { [Counter.self] }
}

enum CounterMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] { [CounterSchemaV1.self] }
    static var stages: [MigrationStage] { [] }
}
