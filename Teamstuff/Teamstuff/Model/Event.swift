//
//  Event.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class Event {
    init(startDate: Date, endDate:Date ,title: String, description: String, location:String, type:String) {
        self.startDate = startDate
        self.endDate = endDate
        self.title = title
        self.description = description
        self.location = location
        self.type = type
    }
    
    init() {
        self.startDate = Date.init()
        self.endDate = Date.init()
        self.title = "DomainDUMMY"
        self.description = "DomainDUMMY"
        self.location = "DomainDUMMY"
        self.type = "Game"
    }
    
    var playerStatus: [String :Bool] = [:]
    var startDate: Date
    var endDate: Date
    var title: String
    var description: String?
    var location: String?
    var type:String
}
