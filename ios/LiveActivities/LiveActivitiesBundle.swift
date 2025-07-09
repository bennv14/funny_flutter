//
//  LiveActivitiesBundle.swift
//  LiveActivities
//
//  Created by bennv on 10/7/25.
//

import WidgetKit
import SwiftUI

@main
struct LiveActivitiesBundle: WidgetBundle {
    var body: some Widget {
        LiveActivities()
        LiveActivitiesControl()
        LiveActivitiesLiveActivity()
    }
}
