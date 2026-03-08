//
//  ClickyWidgetBundle.swift
//  ClickyWidget
//
//  Created by Brandon Potts on 3/8/26.
//

import WidgetKit
import SwiftUI

@main
struct ClickyWidgetBundle: WidgetBundle {
    var body: some Widget {
        ClickyWidget()
        ClickyWidgetControl()
        ClickyWidgetLiveActivity()
    }
}
