//
//  PlayerStatusTableViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 14/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class PlayerStatusTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    
    var availablePlayersId : [String] = []
    var notAvailablePlayersId : [String] = []
    
    var availablePlayersName: [String] = []
    var notAvailablePlayersName: [String] = []
    
    //Create on demand
    var mySections:[SectionData] {
        if(_mySections == nil){
            _mySections = {
                let titleAvailable = "Available (" + String(availablePlayersId.count) + ")"
                let titleNotAvailable = "Not available (" + String(notAvailablePlayersId.count) + ")"
                
                let section1 = SectionData(title: titleAvailable, data: self.availablePlayersName)
                let section2 = SectionData(title: titleNotAvailable, data: self.notAvailablePlayersName)
                
                return [section1, section2]
            }()
        }
        
        return _mySections!
    }
    
    var _mySections: [SectionData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        
        fetchPlayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
        self._mySections = nil
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func fetchPlayers(){
        ref.child("Users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            var availablePlayersName2 : [String] = []
            var notAvailablePlayersName2 : [String] = []
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                do {
                    if(self.availablePlayersId.contains(child.key)){
                        let model = try FirebaseDecoder().decode(User.self, from: child.value!)
                        availablePlayersName2.append(model.name)
                    } else if (self.notAvailablePlayersId.contains(child.key)){
                        let model = try FirebaseDecoder().decode(User.self, from: child.value!)
                        notAvailablePlayersName2.append(model.name)
                    }
                } catch let error {
                    print(error)
                }
            }
            
            self.availablePlayersName = availablePlayersName2
            self.notAvailablePlayersName = notAvailablePlayersName2
            self._mySections = nil
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mySections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mySections[section].numberOfItems
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerStatus", for: indexPath)
        let cellTitle = mySections[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellTitle
        // Configure the cell...
        return cell
    }
}
