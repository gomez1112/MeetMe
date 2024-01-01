//
//  Event+Extension.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import Foundation
import SwiftData

extension Event {
    static let event1 = Event(name: "809 Night Club", location: "Dyckman")
    static let event2 = Event(name: "New Born", location: "New York City")
    
    static func insertSampleData(context: ModelContext) {
        context.insert(event1)
        context.insert(event2)
        
        context.insert(Person.nicole)
        context.insert(Person.stefan)
        
        Person.nicole.metAt = event1
        Person.stefan.metAt = event2
        Person.Felix.metAt = event1
    }
}
