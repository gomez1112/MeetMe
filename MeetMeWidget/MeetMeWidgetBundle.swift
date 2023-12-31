//
//  MeetMeWidgetBundle.swift
//  MeetMeWidget
//
//  Created by Gerard Gomez on 12/31/23.
//

import WidgetKit
import SwiftUI

@main
struct MeetMeWidgetBundle: WidgetBundle {
    var body: some Widget {
        MeetMeWidget()
        MeetMeWidgetLiveActivity()
    }
}
