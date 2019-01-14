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

struct SectionData {
    let title: String
    let data : [String]
    
    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> String {
        return data[index]
    }
}

extension SectionData {
    //  Putting a new init method here means we can
    //  keep the original, memberwise initaliser.
    init(title: String, data: String...) {
        self.title = title
        self.data  = data
    }
}
