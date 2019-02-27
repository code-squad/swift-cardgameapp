//
//  ExtensionNotificationName.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let cardStackDidChange = Notification.Name("cardStackDidChange")
    static let pileDidChange = Notification.Name("pileDidChange")
    static let previewDidChange = Notification.Name("previewDidChange")
    static let columnDidChange = Notification.Name("columnDidChange")
    static let goalDidChange = Notification.Name("goalDidChange")
    
    static let doubleTapCardView = Notification.Name("doubleTapCardView")
    static let doubleTapPreviewView = Notification.Name("doubleTapPreviewView")
    static let doubleTapGoalView = Notification.Name("doubleTapGoalView")
    static let doubleTapColumnView = Notification.Name("doubleTapColumnView")
}
