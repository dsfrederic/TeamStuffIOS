//
//  AddEventControllerViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 02/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import os.log
import Eureka


class AddEventViewController: FormViewController {
//    TODO
//    Show error when event is not saved because of validation
//    * implement other event values
//          -creator/admin
//          -role restriction
//    *form validation
//          required
//          date in future
//          new
//          start < end date
    //    Problem: save button is enabled when all fields are empty
//    Save button should only be enabled when all fields are valid
//
    var event: Event?
    var availablePlayers = ["Jos", "Mark", "Maurice", "Xavier", "Louis", "Els"]
    var positions = ["Loosehead prop", "Hooker", "Tighthead Prop", "Open Lock", "closed Lock", "Open Flanker"]
    
    
    struct FormItems {
        static let name = "name"
        static let type = "type"
        static let dateStart = "dateStart"
        static let dateEnd = "dateEnd"
        static let address = "address"
        static let description = "description"
    }
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
//    Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, HH:mm"

        form +++ Section("General information")
            <<< TextRow(FormItems.name) { row in
                row.title = "Name"
                row.placeholder = "Event name"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
            }
            .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                        self.saveButton.isEnabled = false
                    }else {
                        self.saveButton.isEnabled = true
                    }
            }
            
            <<< TextAreaRow(FormItems.description) { row in
                row.title = "Description"
                row.placeholder = "Write here an optional description"
            }
            <<< TextRow(FormItems.address) { row in
                row.title = "Address"
                row.placeholder = "Write here"
            }
            <<< PickerInputRow<String>(FormItems.type) { row in
                row.title = "Type"
                row.options = ["Game", "Training", "Other"]
                row.add(rule: RuleRequired())
        
            }
            <<< DateTimeRow(FormItems.dateStart) { row in
                row.title = "Start date"
                row.add(rule: RuleRequired())
                row.dateFormatter = formatter
                
                
            }
            <<< DateTimeRow(FormItems.dateEnd) { row in
                row.title = "End date"
                row.add(rule: RuleRequired())
                row.dateFormatter = formatter
            }
            
        //TODO IF TYPE IS GAME
        +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete, .Reorder],
                           header: "Lineup",
                           footer: "Click on add to add a player. Swipe to the right to delete a position") { row in
                            
                             row <<< SwitchRow("SwitchRow") { row in      // initializer
                                    row.title = "Lineup is private"
                                    }.onChange { row in
                                        row.title = (row.value ?? false) ? "Lineup is public" : "Lineup is private"
                                        row.updateCell()
                            }
                            
                            row.multivaluedRowToInsertAt = { index in
                                return PushRow<String>{
                                    //TODO EDITABLE LABEL
                                    $0.title = "\(index+1)"
                                    //AVAILABLE PLAYERS
                                    $0.options = self.availablePlayers
                            }
                        }
                            for position in positions {
                               row <<< PushRow<String> {
                                    $0.title = position
                                    $0.options = self.availablePlayers
                                }
                            }
                            
        }
        
        self.tableView?.isScrollEnabled = true
    }
    
//   Helpers
    
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        //CHECK IF FORM IS VALID
        if form.validate().isEmpty {
            let valuesDictionary = form.values()
            event = Event(date: valuesDictionary[FormItems.dateStart] as! Date
                , title: valuesDictionary[FormItems.name] as! String)
        }

    }
}
