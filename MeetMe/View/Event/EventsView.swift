//
//  EventsView.swift
//  MeetMe
//
//  Created by Gerard Gomez on 1/1/24.
//

import SwiftData
import SwiftUI

struct EventsView: View {
    @Environment(\.modelContext) private var context
    @Query private var events: [Event]
    @Binding var selectedEvent: Event?
    @State private var isAddingEvent = false
    var body: some View {
        if !events.isEmpty {
            NavigationStack {
                List(selection: $selectedEvent) {
                    ForEach(events) { event in
                        NavigationLink {
                            EventDetailView(event: event)
                        } label: {
                            Text(event.location)
                        }
                    }
                    .onDelete(perform: deleteEvents)
                }
                .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Locations")
            }

        } else {
            ContentUnavailableView {
                Label("No Person Yet", systemImage: "person")
            } description: {
                Text("Click the + to add a person")
            } actions: {
                Button {
                    isAddingEvent.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddingEvent) {
                EventEditor(event: nil)
            }
        }
    }
    func deleteEvents(at offsets: IndexSet) {
        for offset in offsets {
            let event = events[offset]
            context.delete(event)
        }
    }
}

#Preview {
    EventsView(selectedEvent: .constant(.event1))
        .modelContainer(PreviewData.container)
}
