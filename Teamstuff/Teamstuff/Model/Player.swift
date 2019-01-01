//
//  Player.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class Player : Member {
    required init(fname: String, lname: String) {
        //TODO
        self.id = "123"
        self.fname = fname
        self.lname = lname
    }
    
    var id: String
    var fname: String
    var lname: String
    var email: String?
    var birthday: String?
    var address: String?
    var telephone: String?
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}
