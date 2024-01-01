//
//  ContentView.swift
//  WatchMeetMe Watch App
//
//  Created by Gerard Gomez on 12/31/23.
//

import SwiftUI

@main
struct WatchMeetMe: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
