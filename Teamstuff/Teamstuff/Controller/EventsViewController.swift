//
//  SecondViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class EventsViewController: UITableViewController {
    
    //TODO refactor to DataSoure and Delegate
    
//PROPERTIES
    var events:[Event] = []
    var ref: DatabaseReference!
    
//INIT
    
//LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("Teams").child(teamIdGlobal).child("Events")
        fetchEvents()
        
        self.clearsSelectionOnViewWillAppear = false
    }
    
    var handle : AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                
            } else {
                self.performSegue(withIdentifier: "returnToLoginEvent", sender: self)
            }
        }
    }
    
    //    Back button, dismissing modal screen, ...
    //    * saving edits
    //    * hide keyboard
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
//HELPER FUNCTIONS
    
    //required for tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return events.count
    }
    //configures and provides a cell to display for a given row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "EventTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        //set cell values
        let calendar = Calendar.current
        let event = events[indexPath.row]
        
        if((event.playerStatus?.keys.contains((Auth.auth().currentUser?.uid)!))!){
            if(event.playerStatus![(Auth.auth().currentUser?.uid)!] == true){
                cell.statusLabel.text = "V"
                cell.statusLabel.textColor = .green
            } else {
                cell.statusLabel.text = "X"
                cell.statusLabel.textColor = .red
            }
        }
        cell.event = event
        cell.titleLabel.text = event.title
        cell.dayDateLabel.text = String(calendar.component(.day, from: event.startDate))
        cell.monthDateLabel.text = event.startDate.monthShort.uppercased()
        cell.typeLabel.text = event.type
        
        return cell
    }
    //Set swipe actions
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let availableAction = UIContextualAction(style: .destructive, title: "Available") { (action, view, handler) in
            
            let currentCell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
            //TODO ICON
            currentCell.statusLabel.text = "V"
            currentCell.statusLabel.textColor = .green
            
            print("Available action")
            
            if (currentCell.event?.playerStatus) != nil {
                currentCell.event?.playerStatus!.updateValue(true, forKey: Auth.auth().currentUser!.uid)
            } else{
                currentCell.event?.playerStatus = [:]
                currentCell.event?.playerStatus!.updateValue(true, forKey: Auth.auth().currentUser!.uid)
            }
            
            self.updateEvent(event: currentCell.event!)
            
            //TODO fix close after action
        }
        availableAction.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [availableAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let notAvailableAction = UIContextualAction(style: .destructive, title: "Not Available") { (action, view, handler) in
            let currentCell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
            //TODO ICON
            currentCell.statusLabel.text = "X"
            currentCell.statusLabel.textColor = .red
            
            print("Not Available action")
            
            if currentCell.event!.playerStatus != nil {
                currentCell.event?.playerStatus!.updateValue(false, forKey: Auth.auth().currentUser!.uid)
            } else{
                currentCell.event?.playerStatus = [:]
                currentCell.event?.playerStatus!.updateValue(false, forKey: Auth.auth().currentUser!.uid)
            }
            
            self.updateEvent(event: currentCell.event!)
            
            //TODO fix close after action
            
        }
        notAvailableAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [notAvailableAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    
    
//NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailView"
        {
            let cell: EventTableViewCell? = sender as? EventTableViewCell
            //CLEAN CODE???
            let vc = segue.destination as? EventDetailViewController
            vc!.event = cell!.event
        }
    }
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddEventViewController, let event = sourceViewController.event {
            addEvent(event: event)
        }
    }
    
//PERSISTENCE
    func updateEvent(event:Event){
        let data = try! FirebaseEncoder().encode(event)
        ref.child(event.id).setValue(data)
    }
    
    func addEvent(event: Event){
        var event = event
        let key = ref.childByAutoId().key
        
        event.id = key!
        let data = try! FirebaseEncoder().encode(event)
        
        ref.child(event.id).setValue(data)
        tableView.reloadData()
    }
    
    func fetchEvents(){
        ref.observe(DataEventType.value, with: { (snapshot) in
            guard snapshot.value != nil else { return }
            do {
                var fetchedEvents: [Event] = []
                
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    let model = try FirebaseDecoder().decode(Event.self, from: child.value!)
                    fetchedEvents.append(model)
                }
                
                fetchedEvents = fetchedEvents.filter{
                    if($0.startDate >= Date.init()){
                        return true
                    } else {
                        return false
                    }
                    }.sorted(by: {
                        $1.startDate.compare($0.startDate) == .orderedDescending
                    })
                
                self.events = fetchedEvents
                
                self.tableView.reloadData()
            } catch let error {
                print(error)
            }
        })
    }

}

