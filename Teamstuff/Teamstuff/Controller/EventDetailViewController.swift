//
//  EventDetailViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 11/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class EventDetailViewController: UIViewController {
    var event: Event?
    var text: String = ""
    var ref: DatabaseReference!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEvent()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ref.removeAllObservers()
    }
    
    func fetchEvent() {
        self.ref = Database.database().reference().child("Teams").child(teamIdGlobal).child("Events").child(event!.id)
        ref.observe(DataEventType.value, with: { (snapshot) in
            guard snapshot.value != nil else { return }
            do {
                let model = try FirebaseDecoder().decode(Event.self, from: snapshot.value!)
                self.event = model
            } catch let error {
                print(error)
            }
        })
    }
    

    /*
    // MARK: - Navigation

     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerStatusTable"
        {
            let vc = segue.destination as? PlayerStatusTableViewController
            
            if(event!.playerStatus != nil){
                vc!.availablePlayersId = Array(event!.playerStatus!.filter{$0.value == true}.keys)
                vc!.notAvailablePlayersId = Array(event!.playerStatus!.filter{$0.value == false}.keys)
            }
            
            vc!.view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

}
