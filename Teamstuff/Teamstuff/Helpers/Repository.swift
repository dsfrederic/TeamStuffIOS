//
//  Repository.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

protocol Repository {
    
    associatedtype T
    
    func getAll() -> [T]
    func get( identifier:Int ) -> T?
    func create( a:T ) -> Bool
    func update( a:T ) -> Bool
    func updateAll( a:[T] ) -> Bool
    func delete( a:T ) -> Bool
    
}
