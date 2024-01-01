//
//  EditPersonView.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import PhotosUI
import SwiftData
import SwiftUI

struct PersonEditor: View {
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    private var editorTitle: String {
        person == nil ? "Add Person" : "Edit Person"
    }
    @State private var isShowingEditEvent = false
    @State private var name = ""
    @State private var emailAddress = ""
    @State private var details = ""
    @State private var metAt: Event?
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    var person: Person?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if let imageData = person?.photo, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.circle)
                    }
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("Select a photo", systemImage: "person")
                    }
                }
                Section {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                Section("Notes") {
                    TextField("Details about his person", text: $details, axis: .vertical)
                }
                Section("Where did you meet them?") {
                    Picker("Met at", selection: $metAt) {
                        Text("Unknown Event")
                            .tag(nil as Event?)
                        if !events.isEmpty {
                            ForEach(events) { event in
                                Text(event.location)
                                    .tag(event as Event?)
                            }
                        }
                    }
                    Button {
                        isShowingEditEvent = true
                    } label: {
                        Text("Add a new Event")
                    }
                }
            }
            .sheet(isPresented: $isShowingEditEvent) {
                EventEditor()
                    .presentationDetents([.medium])
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let person {
                    name = person.name
                    emailAddress = person.emailAddress
                    details = person.details
                    metAt = person.metAt
                    
                }
            }
#if os(macOS)
            .padding()
#endif
            .navigationTitle("Edit Person")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: selectedItem, loadPhoto)
    }
    private func save() {
        if let person {
            person.name = name
            person.emailAddress = emailAddress
            person.details = details
            person.metAt = metAt
        } else {
            let newPerson = Person(name: name, emailAddress: emailAddress, details: details)
            newPerson.metAt = metAt
            context.insert(newPerson)
        }
    }
    func loadPhoto() {
        Task { @MainActor in
            person?.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    PersonEditor()
        .modelContainer(PreviewData.container)
}
