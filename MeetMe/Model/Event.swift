//
//  Event.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import Foundation
import SwiftData

@Model
final class Event {
    var name = ""
    var location = ""
    var date = Date()
    @Relationship(deleteRule: .cascade, inverse: \Person.metAt)
    var people: [Person]? = [Person]()
    
    init(name: String = "", location: String = "") {
        self.name = name
        self.location = location
    }
}
