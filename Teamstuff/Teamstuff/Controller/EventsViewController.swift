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
        
        let calendar = Calendar.current
        
        let event = events[indexPath.row]
        cell.titleLabel.text = event.title
        cell.dayDateLabel.text = String(calendar.component(.day, from: event.date))
        cell.monthDateLabel.text = String(calendar.component(.month, from: event.date))
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

