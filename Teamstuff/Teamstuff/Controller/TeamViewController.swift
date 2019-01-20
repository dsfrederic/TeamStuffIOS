//
//  TeamViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import CodableFirebase

class TeamViewController: UIViewController {
//VIEW CONNECTIONS
    @IBOutlet weak var collectionView: UICollectionView!
    
//PROPERTIES
    var messages:[Message] = []
    var ref: DatabaseReference!
    
//LIFECYCLE
    override func viewDidLoad() {
        self.ref = Database.database().reference().child("Teams").child(teamIdGlobal).child("Messages")
        
        fetchMessages()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshMessages(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //Set estimadItemSize to toggle self sizing
            flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width-20, height: 300)
        }
    }

//NAVIGATION
    @IBAction func unwindToMessages(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddMessageViewController, let message = sourceViewController.message {
            let messageObject = Message(message: message, author: Auth.auth().currentUser!.displayName! , authorId: Auth.auth().currentUser!.uid, postDate: Date.init())
            addMessage(message: messageObject)
            collectionView.reloadData()
        }
    }
    
    @objc private func refreshMessages(_ sender: Any) {
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
    
//PERSISTENCE
    

    func addMessage(message: Message){
        let data = try! FirebaseEncoder().encode(message)
        ref.childByAutoId().setValue(data)
    }
    
    func fetchMessages(){
        ref.observe(DataEventType.value, with: { (snapshot) in
            guard snapshot.value != nil else { return }
            do {
                var fetchedMessages: [Message] = []
                
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    let model = try FirebaseDecoder().decode(Message.self, from: child.value!)
                    fetchedMessages.append(model)
                }
                
                self.messages = fetchedMessages.reversed()
                
                self.collectionView.reloadData()
            } catch let error {
                print(error)
            }
        })
    }
}

extension TeamViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageIdentifier", for: indexPath) as! MessageCollectionViewCell
        
        let message = messages[indexPath.item]
        
        cell.nameLabel.text = message.author
        cell.messageTextLabel.text = message.message
        let formatter = DateFormatter()
        //formatter.dateFormat = "dd MMM HH:mm"
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        formatter.doesRelativeDateFormatting = true
        cell.postedDateLabel.text = message.postDate.relativeTime
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        
        return cell
    }
}

extension TeamViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}


