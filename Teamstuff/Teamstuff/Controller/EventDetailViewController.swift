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
    
    var event: Event = Event()
    var text: String = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = event.title
//        self.dateLabel.text = event.date
        self.descriptionLabel.text = event.description
    }
    

    /*
    // MARK: - Navigation

     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerStatusTable"
        {
            let vc = segue.destination as? PlayerStatusTableViewController
            
            vc!.view.translatesAutoresizingMaskIntoConstraints = false
            
            let availablePlayersId = Array(event.playerStatus.filter{$0.value == true}.keys)
            print(availablePlayersId)
            vc!.availablePlayers = membersRepo!.getNamesById(identifiers: availablePlayersId)
            let notAvailablePlayersId = Array(event.playerStatus.filter{$0.value == false}.keys)
            print(notAvailablePlayersId)
            vc!.notAvailablePlayers = membersRepo!.getNamesById(identifiers: notAvailablePlayersId)
            
        }
    }
    
    

}
