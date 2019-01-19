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
    
    var event: Event?
    var text: String = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(event != nil){
            self.title = event!.title
            //        self.dateLabel.text = event.date
            self.descriptionLabel.text = event!.description
            
            //TODO MOVE TO REPOSITORY?
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM HH:mm"
            self.dateLabel.text = String("From "+formatter.string(from: event!.startDate) + " to " + formatter.string(from: event!.endDate))
            
            self.locationLabel.text = event!.location;
        }
    }
    

    /*
    // MARK: - Navigation

     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerStatusTable"
        {
            let vc = segue.destination as? PlayerStatusTableViewController
            vc!.view.translatesAutoresizingMaskIntoConstraints = false
            if(event!.playerStatus != nil){
                let availablePlayersId = Array(event!.playerStatus!.filter{$0.value == true}.keys)
                vc!.availablePlayers = membersRepo!.getNamesById(identifiers: availablePlayersId)
                let notAvailablePlayersId = Array(event!.playerStatus!.filter{$0.value == false}.keys)
                vc!.notAvailablePlayers = membersRepo!.getNamesById(identifiers: notAvailablePlayersId)
            }
            
            
        }
    }
    
    

}
