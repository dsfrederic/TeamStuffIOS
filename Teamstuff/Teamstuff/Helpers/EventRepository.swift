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
        let today = Date.init()
        
        
        var events = [
            Event(date: today,
                  title: "EventTitle"),
            Event(date: Calendar.current.date(byAdding: .day, value: 1, to: today)!,
                  title: "EventTitle"),
            Event(date: Calendar.current.date(byAdding: .day, value: 2, to: today)!,
                  title: "EventTitle"),
            Event(date: Calendar.current.date(byAdding: .day, value: 3, to: today)!,
                  title: "EventTitle"),
            Event(date: Calendar.current.date(byAdding: .day, value: -3, to: today)!,
                  title: "EventTitle"),
            Event(date: Calendar.current.date(byAdding: .day, value: -2, to: today)!,
                  title: "EventTitle"),
            Event(date: Calendar.current.date(byAdding: .day, value: -1, to: today)!,
                  title: "EventTitle")
        ]
        
        events = events.sorted(by: {
            $1.date.compare($0.date) == .orderedDescending
        })
        
        events = events.filter{
            if($0.date >= Date.init()){
                return true
            } else {
                return false
            }
        }
        
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
