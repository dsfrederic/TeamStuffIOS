//
//  TeamViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

class TeamViewController: UIViewController {
    
    var messages:[Message] = []
    var teamRepo = TeamRepository()
    var memberRepo = MemberRepository()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
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
    
    @IBAction func unwindToMessages(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddMessageViewController, let message = sourceViewController.message {
            let messageObject = Message(message: message, author: memberRepo.getCurrentUser().fname + " " + memberRepo.getCurrentUser().lname, authorId: memberRepo.getCurrentUser().id, postDate: Date.init())
            print(messages.count)
            addMessage(message: messageObject)
            print(messages.count)
            fetchMessages()
            print(messages.count)
        }
    }
    
    @objc private func refreshMessages(_ sender: Any) {
        fetchMessages()
        
        collectionView.refreshControl?.endRefreshing()
    }
    
//PERSISTENCE
    func addMessage(message: Message){
        _ = teamRepo.create(a: message)
    }
    
    func fetchMessages(){
        self.messages = teamRepo.getAll()
        collectionView.reloadData()
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
//        formatter.dateFormat = "dd MMM HH:mm"
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
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
}

extension TeamViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}


