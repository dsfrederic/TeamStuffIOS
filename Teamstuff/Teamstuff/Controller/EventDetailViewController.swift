//
//  EventDetailViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 11/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    lazy var membersRepo: MemberRepository? = MemberRepository()
    
    var event: Event = Event(date: Date.init(), title: "Dummy")
    var text: String = ""
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = event.title
        
    }
    

    /*
    // MARK: - Navigation

     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerStatusTable"
        {
            let vc = segue.destination as? PlayerStatusTableViewController
            
            var availablePlayersId = Array(event.playerStatus.filter{$0.value == true}.keys)
            vc!.availablePlayers = membersRepo!.getNamesById(identifiers: availablePlayersId)
            
            var notAvailablePlayersId = Array(event.playerStatus.filter{$0.value == false}.keys)
            vc!.notAvailablePlayers = membersRepo!.getNamesById(identifiers: notAvailablePlayersId)
            
        }
    }
    
    

}
