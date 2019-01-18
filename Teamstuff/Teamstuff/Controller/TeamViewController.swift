//
//  TeamViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Foundation

import UIKit

//class TeamViewController: UIViewController {
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//    }
//
//
//}

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
}

class TeamViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: 120)
//        }
    }
}

extension TeamViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageIdentifier", for: indexPath) as! MessageCollectionViewCell
        
        cell.nameLabel.text = "Frederic De Smet"
        cell.messageTextLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pretium dolor nec lorem euismod lobortis. Sed interdum ultricies neque sit amet efficitur. Nullam facilisis turpis ut ex placerat, faucibus lobortis lorem dictum."
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        cell.postedDateLabel.text = String(formatter.string(from: Date.init()))
        
        return cell
    }
}

extension TeamViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}
