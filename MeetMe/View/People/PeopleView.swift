//
//  PeopleView.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import SwiftData
import SwiftUI

struct PeopleView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(DataModel.self) private var model
    @Binding var selectedPerson: Person?
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    @State private var searchText = ""
    var body: some View {
        @Bindable var model = model
        NavigationStack {
            List(selection: $selectedPerson) {
                PeopleList(searchString: searchText, sortOrder: sortOrder)
            }
            .searchable(text: $searchText)
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name (A-Z)")
                            .tag([SortDescriptor(\Person.name)])
                        Text("Name (Z-A)")
                            .tag([SortDescriptor(\Person.name, order: .reverse)])
                    }
                }
                if prefersTabNavigation {
                    Button {
                        model.isAddingPerson.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $model.isAddingPerson) {
                        PersonEditor(person: nil)
                    }
                }
            }
        }
    }
}

#Preview {
    PeopleView(selectedPerson: .constant(.Felix))
        .environment(DataModel())
        .modelContainer(PreviewData.container)
}

struct PeopleList: View {
    @Environment(DataModel.self) private var model
    @Environment(\.modelContext) private var context
    @Environment(\.isSearching) private var isSearching
    @Query private var people: [Person]
    init(searchString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        _people = Query(filter: #Predicate { searchString.isEmpty ? true : ($0.name.localizedStandardContains(searchString) || $0.emailAddress.localizedStandardContains(searchString) || $0.details.localizedStandardContains(searchString))}, sort: sortOrder)
    }
    var body: some View {
        @Bindable var model = model
        if !people.isEmpty {
            ForEach(people) { person in
                NavigationLink {
                    PersonDetailView(person: person)
                } label: {
                    Text(person.name)
                }
            }
            .onDelete(perform: deletePeople)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("People")
        } else {
            if isSearching {
                ContentUnavailableView.search
            } else {
                ContentUnavailableView {
                    Label("No Person Yet", systemImage: "person")
                } description: {
                    Text("Click the + to add a person")
                } actions: {
                    Button {
                        model.isAddingPerson.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $model.isAddingPerson) {
                    PersonEditor(person: nil)
                }
            }
        }
    }
    func deletePeople(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            context.delete(person)
        }
    }
}
