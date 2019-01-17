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
        let startDate = Date.init()
        let date = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        let date1 = Calendar.current.date(byAdding: .day, value: 8, to: startDate)!
        let date2 = Calendar.current.date(byAdding: .day, value: 31, to: startDate)!
        //let date3 = Calendar.current.date(byAdding: .day, value: 10, to: startDate)!
        let date4 = Calendar.current.date(byAdding: .day, value: 54, to: startDate)!
        
        
        var events = [
            Event(startDate: date, endDate: date, title: "DRC-ROC", description: "Bekerwedstrijd", location: "Van Langehovenstraat 9200 Dendermonde", type: "Game"),
            Event(startDate: date1, endDate: date1, title: "DRC-Frameries", description: "Competitiewedstrijd", location: "Van Langehovenstraat 9200 Dendermonde", type: "Game"),
            Event(startDate: date4, endDate: date4, title: "Teambuilding", description: "Bekerwedstrijd", location: "De kust", type: "Other"),
            Event(startDate: date2, endDate: date2, title: "Gym session", description: "Gym session voor uitleg nieuwe schema met uitleg want goede uitvoering is alles", location: "Van Langehovenstraat 9200 Dendermonde", type: "Training")
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
