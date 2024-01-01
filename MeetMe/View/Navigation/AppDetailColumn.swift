//
//  AppDetailColumn.swift
//  MeetMe
//
//  Created by Gerard Gomez on 1/1/24.
//

import SwiftUI

struct AppDetailColumn: View {
    @Binding var selectedPerson: Person?
    @Binding var selectedEvent: Event?
    var body: some View {
        Group {
            if let selectedPerson {
                PersonDetailView(person: selectedPerson)
            }
            if let selectedEvent {
                EventDetailView(event: selectedEvent)
            } else {
                ContentUnavailableView("Select an Item", systemImage: "folder")
            }
        }
    }
}

#Preview {
    AppDetailColumn(selectedPerson: .constant(.Felix), selectedEvent: .constant(.event1))
}
