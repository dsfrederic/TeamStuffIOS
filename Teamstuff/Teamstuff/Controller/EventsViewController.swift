//
//  SecondViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {
    
//PROPERTIES
    lazy var eventsRepo: EventRepository? = EventRepository()
    lazy var membersRepo: MemberRepository? = MemberRepository()
    
    //TODO: START ON FIRST EVENT IN THE FUTURE
    var events:[Event] = []
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddEventViewController, let event = sourceViewController.event {
            let newIndexPath = IndexPath(row: events.count, section: 0)
            events.append(event)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
//INIT
    
//LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        fetchEvents()
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
        cell.event = event
        cell.titleLabel.text = event.title
        cell.dayDateLabel.text = String(calendar.component(.day, from: event.date))
        cell.monthDateLabel.text = event.date.monthShort.uppercased()
        
        return cell
    }
    //Set swipe actions
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let availableAction = UIContextualAction(style: .destructive, title: "Available") { (action, view, handler) in
            
            let currentCell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
            //TODO ICON
            currentCell.statusLabel.text = "Available"
            currentCell.statusLabel.textColor = .green
            currentCell.event.playerStatus[self.membersRepo!.getCurrentUser().id] = true
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
            print("NOT AVAILABLE swipe")
            let currentCell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
            //TODO ICON
            currentCell.statusLabel.text = "Not available"
            currentCell.statusLabel.textColor = .red
            currentCell.event.playerStatus[self.membersRepo!.getCurrentUser().id] = false
            
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
            print("executed")
            let cell: EventTableViewCell? = sender as? EventTableViewCell
            //CLEAN CODE???
            let vc = segue.destination.children[0] as? EventDetailViewController
            vc!.event = cell!.event
            print(cell!.event)
            print(vc!.event)
        }
    }
    
//PERSISTENCE
    func saveEvents(){
        
    }
    
    func fetchEvents(){
        events = eventsRepo!.getAll()
    }

}

