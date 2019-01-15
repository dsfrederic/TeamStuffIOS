//
//  MemberRepository.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class MemberRepository:Repository {
    
    func getAll() -> [Member] {
        let members = [Member(fname: "Frederic", lname: "De Smet"), Member(fname: "Frederic", lname: "De Smet")]
        return members
    }
    func get( identifier:Int ) -> Member? {
        //TODO
        return Member(fname: "Frederic", lname: "De Smet")
    }
    
    func getNamesById( identifiers:[String] ) ->  [String] {
        let members = ["Frederic","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc"]
        return members
    }
    
    func getCurrentUser() -> Member {
        //TODO
        let currentUser = Member(fname: "Frederic", lname: "De Smet")
        currentUser.id = "idFredericDesmet"
        return currentUser
    }
    
    func create( a:Member ) -> Bool {
        return true
    }
    func update( a:Member ) -> Bool {
        return true
    }
    func delete( a:Member ) -> Bool {
        return true
    }
}
