//
//  MemberRepository.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

class MemberRepository:Repository {
    func updateAll(a: [User]) -> Bool {
        return true
    }
    
    
    func getAll() -> [User] {
        let members = [User(fname: "Frederic", lname: "De Smet"), User(fname: "Frederic", lname: "De Smet")]
        return members
    }
    func get( identifier:Int ) -> User? {
        //TODO
        return User(fname: "Frederic", lname: "De Smet")
    }
    
    func getNamesById( identifiers:[String] ) ->  [String] {
        let members = ["Frederic","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc","Jean", "Marc"]
        return members
    }
    
    func getCurrentUser() -> User {
        //TODO
        let currentUser = User(fname: "Frederic", lname: "De Smet")
        currentUser.id = "idFredericDesmet"
        return currentUser
    }
    
    func create( a:User ) -> Bool {
        return true
    }
    func update( a:User ) -> Bool {
        return true
    }
    func delete( a:User ) -> Bool {
        return true
    }
}
