//
//  Member.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class User : Codable{
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    var id: String
    
    var name: String
    
    var teamId: String?
}
