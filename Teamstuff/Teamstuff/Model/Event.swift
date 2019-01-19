//
//  Event.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

struct Event : Codable {
    
    //TODO REMOVE INIT
    init(startDate: Date, endDate:Date ,title: String, description: String, location:String, type:String) {
        self.startDate = startDate
        self.endDate = endDate
        self.title = title
        self.description = description
        self.location = location
        self.type = type
        self.id = "DummyID"
    }

    var id:String
    var startDate: Date
    var endDate: Date
    var title: String
    var description: String?
    var location: String?
    var type:String
    var playerStatus: [String :Bool]?
}
