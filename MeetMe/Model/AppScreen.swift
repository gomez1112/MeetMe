//
//  AppScreen.swift
//  MeetMe
//
//  Created by Gerard Gomez on 1/1/24.
//

import SwiftUI

enum AppScreen: Identifiable, Hashable, CaseIterable {
    case people
    case events
    
    var id: Self { self }
    
    @ViewBuilder
    var label: some View {
        switch self {
            case .people:
                Label("People", systemImage: "person.3")
            case .events:
                Label("Events", systemImage: "calendar")
        }
    }
    
    @ViewBuilder
    func destination(selectedPerson: Binding<Person?>, selectedEvent: Binding<Event?>) -> some View {
        switch self {
            case .people:
                PeopleView(selectedPerson: selectedPerson)
            case .events:
                EventsView(selectedEvent: selectedEvent)
        }
    }
}
