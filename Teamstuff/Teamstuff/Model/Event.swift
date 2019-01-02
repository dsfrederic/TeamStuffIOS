//
//  Event.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class Event {
    init(date: Date, title: String) {
        self.date = date
        self.title = title
    }
    
    var date: Date
    var title: String
    var description: String?
}
