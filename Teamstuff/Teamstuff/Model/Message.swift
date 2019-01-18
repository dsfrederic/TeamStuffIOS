//
//  Message.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 18/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit

class Message {
    var message:String
    var author:String
    var authorId:String
    var postDate:Date
    
    init(message: String, author:String, authorId: String, postDate:Date) {
        self.message = message
        self.author = author
        self.authorId = authorId
        self.postDate = postDate
    }
}
