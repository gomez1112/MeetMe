//
//  Person.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import Foundation
import SwiftData

@Model
final class Person {
    var name = ""
    var emailAddress = ""
    var details = ""
    var metAt: Event?
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String = "", emailAddress: String = "", details: String = "", metAt: Event? = nil) {
        self.name = name
        self.emailAddress = emailAddress
        self.details = details
        self.metAt = metAt
    }
}
