//
//  Member.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

protocol Member: Equatable{
    
    var id: String {get set}
    
    var fname: String {get set}
    //lname
    var lname: String {get set}
    //email
    var email: String? {get set}
    //birthday
    var birthday: String? {get set}
    //address
    var address: String? {get set}
    //telephone
    var telephone: String? {get set}
}
