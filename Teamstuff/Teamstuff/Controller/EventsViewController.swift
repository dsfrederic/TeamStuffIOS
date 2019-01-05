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
    
    var events:[Event] = []
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddEventViewController, let event = sourceViewController.event {
            let newIndexPath = IndexPath(row: events.count, section: 0)
            events.append(event)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
//INIT
    
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
        cell.titleLabel.text = event.title
        cell.dayDateLabel.text = String(calendar.component(.day, from: event.date))
        cell.monthDateLabel.text = event.date.monthShort.uppercased()
        
        
        
        return cell
    }
    
    
//NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    
//LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        fetchEvents()
    }
    
//PERSISTENCE
    func saveEvents(){
        
    }
    
    func fetchEvents(){
        events = eventsRepo!.getAll()
    }

}

