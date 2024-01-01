//
//  AppSidebarList.swift
//  MeetMe
//
//  Created by Gerard Gomez on 1/1/24.
//

import SwiftUI

struct AppSidebarList: View {
    @Environment(DataModel.self) private var model
    @Binding var selectedScreen: AppScreen?
    var body: some View {
        @Bindable var model = model
        List(selection: $selectedScreen) {
            ForEach(AppScreen.allCases) { screen in
                NavigationLink(value: screen) {
                    screen.label
                }
            }
        }
        .toolbar {
            Button {
                model.isAddingPerson.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $model.isAddingPerson) {
            PersonEditor(person: nil)
        }
        .navigationTitle("MeetMe")
    }
}

#Preview {
    AppSidebarList(selectedScreen: .constant(.people))
        .environment(DataModel())
}
