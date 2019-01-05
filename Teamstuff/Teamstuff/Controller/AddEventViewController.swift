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
    struct FormItems {
        static let name = "name"
        static let type = "type"
        static let date = "date"
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
//    Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("About You")
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
            <<< PickerInputRow<String>(FormItems.type) { row in
                row.title = "Type"
                row.options = ["Game", "Training", "Other"]
                row.add(rule: RuleRequired())
        
            }
            <<< DateRow(FormItems.date) { row in
                row.title = "Date"
                row.add(rule: RuleRequired())
            }
    }
    
//   Helpers
    
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        if form.validate().isEmpty {
            let valuesDictionary = form.values()
            event = Event(date: valuesDictionary[FormItems.date] as! Date
                , title: valuesDictionary[FormItems.name] as! String)
        }
    }
}
