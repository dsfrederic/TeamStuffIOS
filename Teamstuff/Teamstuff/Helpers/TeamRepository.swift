//
//  TeamRepository.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 18/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit

class TeamRepository: Repository {
    
    var messages:[Message] = []
    
    init() {
        let startDate = Date.init()
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date.init())!
        let date1 = Calendar.current.date(byAdding: .day, value: -8, to: Date.init())!
        let date2 = Calendar.current.date(byAdding: .day, value: -31, to: Date.init())!
        let date3 = Calendar.current.date(byAdding: .day, value: -10, to: startDate)!
        let date4 = Calendar.current.date(byAdding: .day, value: -54, to: Date.init())!
        
        
        messages = [
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pretium dolor nec lorem euismod lobortis. Sed interdum ultricies neque sit amet efficitur. Nullam facilisis turpis ut ex placerat, faucibus lobortis lorem dictum.", author: "Michael Hooper", authorId: "AUTHOR ID", postDate: startDate),
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", author: "Frederic De Smet", authorId: "AUTHOR ID", postDate: date),
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pretium dolor nec lorem euismod lobortis. ", author: "Frederic De Smet", authorId: "AUTHOR ID", postDate: date2),
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pretium dolor nec lorem euismod lobortis. Sed interdum ultricies neque sit amet efficitur. Nullam facilisis turpis ut ex placerat, faucibus lobortis lorem dictum.", author: "Marc Van De Velde", authorId: "AUTHOR ID", postDate: date3),
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pretium dolor nec lorem euismod lobortis. Sed interdum ultricies neque sit amet efficitur. Nullam facilisis turpis ut ex placerat, faucibus lobortis lorem dictum.", author: "Frederic De Smet", authorId: "AUTHOR ID", postDate: date4),
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", author: "Jean De Clerq", authorId: "AUTHOR ID", postDate: date1),
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", author: "Laurent Dierickx", authorId: "AUTHOR ID", postDate: date3),
            Message(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", author: "Jos Vermeulen", authorId: "AUTHOR ID", postDate: date2),
        ]
    }
    
    func getAll() -> [Message] {
        messages = messages.sorted(by: {
            $1.postDate.compare($0.postDate) == .orderedAscending
        })
        
        return messages
    }
    func get( identifier:Int ) -> Message? {
        return messages[0]
    }
    
    func update(a: Message) -> Bool {
        return true
    }
    
    func create( a:Message ) -> Bool {
        messages.append(a)
        
        return true
    }
    
    func updateAll( a messages:[Message] ) -> Bool {
        self.messages = messages
        return true
    }
    func delete( a:Message ) -> Bool {
        return true
    }
}
