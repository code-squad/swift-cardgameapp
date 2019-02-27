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
}
