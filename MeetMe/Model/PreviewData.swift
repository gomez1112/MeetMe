//
//  PreviewData.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import Foundation
import SwiftData

actor PreviewData {
    static var container: ModelContainer = {
       createContainer
    }()
    
    static private var createContainer: ModelContainer {
        let schema = Schema([Person.self, Event.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            Task { @MainActor in
                Event.insertSampleData(context: container.mainContext)
            }
            return container
        } catch {
            fatalError("Cannot load container: \(error.localizedDescription)")
        }
    }
}
