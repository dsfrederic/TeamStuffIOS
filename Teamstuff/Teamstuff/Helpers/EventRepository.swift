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
        
        var events = [
            Event(),
            Event(),
            Event(),
            Event(),
            Event(),
            Event(),
            Event()
        ]
        
        events = events.sorted(by: {
            $1.startDate.compare($0.startDate) == .orderedDescending
        })
        
        events = events.filter{
            if($0.startDate >= Date.init()){
                return true
            } else {
                return false
            }
        }
        
        return events
    }
    func get( identifier:Int ) -> Event? {
        return Event()
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
