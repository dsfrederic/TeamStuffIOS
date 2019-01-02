//
//  EventRepository.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class EventRepository: Repository{
    func getAll() -> [Event] {
        let events = [Event(date: Date.init(), title: "EventTitle"), Event(date: Date.init(), title: "EventTitle"), Event(date: Date.init(), title: "EventTitle"), Event(date: Date.init(), title: "EventTitle")]
        return events
    }
    func get( identifier:Int ) -> Event? {
        return Event(date: Date.init(), title: "EventTitle")
    }
    func create( a:Event ) -> Bool {
        return true
    }
    func update( a:Event ) -> Bool {
        return true
    }
    func delete( a:Event ) -> Bool {
        return true
    }
}
