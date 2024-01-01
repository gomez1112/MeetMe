//
//  EventEditor.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import SwiftData
import SwiftUI

struct EventEditor: View {
    @Query(sort: [ SortDescriptor(\Event.name), SortDescriptor(\Event.location)])
    var events: [Event]
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    private var editorTitle: String {
        event == nil ? "Add Event" : "Edit Event"
    }
    var event: Event?
  
    @State private var name = ""
    @State private var location = ""
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name of event", text: $name)
                TextField("Location", text: $location)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let event {
                    name = event.name
                    location = event.location
                }
            }
            #if os(macOS)
            .padding()
            #endif
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private func save() {
        if let event {
            event.name = name
            event.location = location
        } else {
            let newEvent = Event(name: name, location: location)
            context.insert(newEvent)
        }
    }
}

#Preview {
    EventEditor(event: Event.event1)
}
