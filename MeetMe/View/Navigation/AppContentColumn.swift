//
//  AppContentColumn.swift
//  MeetMe
//
//  Created by Gerard Gomez on 1/1/24.
//

import SwiftUI

struct AppContentColumn: View {
    @Binding var selectedScreen: AppScreen?
    @Binding var selectedPerson: Person?
    @Binding var selectedEvent: Event?
    var body: some View {
        Group {
            if let selectedScreen {
                selectedScreen.destination(selectedPerson: $selectedPerson, selectedEvent: $selectedEvent)
            } else {
                ContentUnavailableView("Select from the sidebar", systemImage: "sidebar.left")
            }
        }
    }
}

#Preview {
    AppContentColumn(selectedScreen: .constant(.people), selectedPerson: .constant(.Felix), selectedEvent: .constant(.event1))
}
