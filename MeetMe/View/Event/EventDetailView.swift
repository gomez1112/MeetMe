//
//  EventDetailView.swift
//  MeetMe
//
//  Created by Gerard Gomez on 1/1/24.
//

import SwiftData
import SwiftUI

struct EventDetailView: View {
    @State private var isEditing = false
    @State private var isDeleting = false
    @Environment(\.modelContext) private var modelContext
    var event: Event?
    var body: some View {
        if let event {
            List {
                Text(event.name)
                Text(event.location)
            }
            .toolbar {
                Button { isEditing = true } label: {
                    Label("Edit \(event.name)", systemImage: "pencil")
                        .help("Edit the event")
                }
                
                Button { isDeleting = true } label: {
                    Label("Delete \(event.name)", systemImage: "trash")
                        .help("Delete the event")
                }
            }
            .sheet(isPresented: $isEditing) {
                EventEditor(event: event)
            }
            .alert("Delete \(event.name)?", isPresented: $isDeleting) {
                Button("Yes, delete \(event.name)", role: .destructive) {
                    delete(event)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(event.name)")
        } else {
            ContentUnavailableView("Select an event", systemImage: "calendar")
        }
    }
    private func delete(_ event: Event) {
        modelContext.delete(event)
    }
}

#Preview {
    EventDetailView()
}
