//
//  PersonDetailView.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import SwiftData
import SwiftUI

struct PersonDetailView: View {
    @State private var isEditing = false
    @State private var isDeleting = false
    @Environment(\.modelContext) private var modelContext
    var person: Person?
    var body: some View {
        if let person {
            List {
                Section {
                    if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.circle)
                    }
                    Text(person.name)
                        .textContentType(.name)
                    Text(person.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                Section("Notes") {
                    Text(person.details)
                }
                Section("Where did you meet them?") {
                    if let metAt = person.metAt {
                        Text(metAt.name)
                    }
                }
            }
            .toolbar {
                Button { isEditing = true } label: {
                    Label("Edit \(person.name)", systemImage: "pencil")
                        .help("Edit the person")
                }
                
                Button { isDeleting = true } label: {
                    Label("Delete \(person.name)", systemImage: "trash")
                        .help("Delete the person")
                }
            }
            .sheet(isPresented: $isEditing) {
                PersonEditor(person: person)
            }
            .alert("Delete \(person.name)?", isPresented: $isDeleting) {
                Button("Yes, delete \(person.name)", role: .destructive) {
                    delete(person)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(person.name)")
        } else {
            ContentUnavailableView("Select a person", systemImage: "person")
        }
    }
    private func delete(_ person: Person) {
        modelContext.delete(person)
    }
}

#Preview {
    PersonDetailView()
}
