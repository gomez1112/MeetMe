//
//  AppTabView.swift
//  MeetMe
//
//  Created by Gerard Gomez on 1/1/24.
//

import SwiftData
import SwiftUI

struct AppTabView: View {
    @Binding var selectedScreen: AppScreen?
    @Binding var selectedPerson: Person?
    @Binding var selectedEvent: Event?
    var body: some View {
        TabView(selection: $selectedScreen) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination(selectedPerson: $selectedPerson, selectedEvent: $selectedEvent)
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    AppTabView(selectedScreen: .constant(.events), selectedPerson: .constant(.Felix), selectedEvent: .constant(.event1))
        .modelContainer(PreviewData.container)
}
