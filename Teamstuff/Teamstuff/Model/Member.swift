//
//  Member.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class Member{
    
    init(fname: String, lname: String) {
        self.fname = fname
        self.lname = lname
    }
    
    var id: String = ""
    
    var fname: String = ""
    //lname
    var lname: String = ""
    //email
    var email: String?
    //birthday
    var birthday: String?
    //address
    var address: String?
    //telephone
    var telephone: String?
    
    var team:Int?
}
