//
//  MeetMeApp.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import SwiftUI
import SwiftData

@main
struct MeetMeApp: App {
    @State private var model = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
        .modelContainer(for: [Event.self, Person.self], isUndoEnabled: true)
    }
}
