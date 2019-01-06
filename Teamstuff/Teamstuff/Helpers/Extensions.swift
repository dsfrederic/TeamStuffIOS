//
//  Extensions.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 02/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation
import Eureka

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var monthShort: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return String(dateFormatter.string(from: self).prefix(3))
    }
}

//checks if form is touched or not
extension Form {
    
    public func isClean() ->Bool {
        for row in rows {
            if row.wasChanged {
                return false
            }
        }
        return true
    }
}