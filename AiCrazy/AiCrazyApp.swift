//
//  AiCrazyApp.swift
//  AiCrazy
//
//  Created by 方曦 on 2023/8/30.
//

import SwiftUI

@main
struct AiCrazyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
