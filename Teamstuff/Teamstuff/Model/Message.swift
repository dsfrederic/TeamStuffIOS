//
//  Message.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 18/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit

class Message : Codable {
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
    
//    func toAnyObject() -> Any {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let convertedPostDate = formatter.string(from: postDate)
//        print(postDate)
//        print("converted: " + convertedPostDate)
//
//        return [
//            "message": message,
//            "author": author,
//            "authorId": authorId,
//            "postDate": convertedPostDate
//        ]
//    }
//
//    init(snapshot:Any) {
//        self.message = snapshot["message"]
//        self.author = snapshot["author"]
//        self.authorId = snapshot["authorId"]
//        self.postDate = snapshot["postDate"]
//    }
}
