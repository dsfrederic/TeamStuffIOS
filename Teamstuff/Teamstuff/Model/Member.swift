//
//  Member.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class Member {
    init(fname:String, lname:String) {
        self.fname = fname
        self.lname = lname
        
        
    }
    
    var fname: String
    //lname
    var lname: String
    //birthday
    var name: String? = nil
    //address
    var address: String? = nil
    //telephone
    var telephone: String? = nil
}
