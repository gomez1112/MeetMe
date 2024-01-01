//
//  ContentView.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @State private var selectedScreen: AppScreen?
    @State private var selectedPerson: Person?
    @State private var selectedEvent: Event?
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selectedScreen: $selectedScreen, selectedPerson: $selectedPerson, selectedEvent: $selectedEvent)
        } else {
            NavigationSplitView {
                AppSidebarList(selectedScreen: $selectedScreen)
            } content: {
                AppContentColumn(selectedScreen: $selectedScreen, selectedPerson: $selectedPerson, selectedEvent: $selectedEvent)
            } detail: {
                AppDetailColumn(selectedPerson: $selectedPerson, selectedEvent: $selectedEvent)
            }
        }
    }
}


#Preview {
    ContentView()
}
