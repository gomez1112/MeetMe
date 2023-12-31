//
//  Item.swift
//  MeetMe
//
//  Created by Gerard Gomez on 12/31/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
