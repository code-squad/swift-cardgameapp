//
//  ExtensionNotificationName.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let cardStackDidAdd = Notification.Name("cardStackDidAdd")
    static let pileDidAdd = Notification.Name("pileDidAdd")
    static let previewDidAdd = Notification.Name("previewDidAdd")
    static let columnDidAdd = Notification.Name("columnDidAdd")
    static let goalDidAdd = Notification.Name("goalDidAdd")
    
    static let cardStackDidPop = Notification.Name("cardStackDidPop")
    static let pileDidPop = Notification.Name("pileDidPop")
    static let previewDidPop = Notification.Name("previewDidPop")
    static let columnDidPop = Notification.Name("columnDidPop")
    static let goalDidPop = Notification.Name("goalDidPop")
    
    static let doubleTapCardView = Notification.Name("doubleTapCardView")
    static let doubleTapPreviewView = Notification.Name("doubleTapPreviewView")
    static let doubleTapGoalView = Notification.Name("doubleTapGoalView")
    static let doubleTapColumnView = Notification.Name("doubleTapColumnView")
}
