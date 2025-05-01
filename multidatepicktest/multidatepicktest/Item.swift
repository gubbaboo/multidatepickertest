//
//  Item.swift
//  multidatepicktest
//
//  Created by Nicholas Allen on 3/20/25.
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
