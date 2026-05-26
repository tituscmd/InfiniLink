//
//  InfiniLinkWidgetsBundle.swift
//  InfiniLinkWidgets
//
//  Created by Titus Kendzorra on 26.05.26.
//

import WidgetKit
import SwiftUI

@main
struct InfiniLinkWidgetsBundle: WidgetBundle {
    var body: some Widget {
        InfiniLinkWidgets()
        InfiniLinkWidgetsControl()
        InfiniLinkWidgetsLiveActivity()
    }
}
