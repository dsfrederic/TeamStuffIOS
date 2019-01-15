//
//  AddEventControllerViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 02/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import Eureka
import os.log
import UIKit

class AddEventViewController: FormViewController {
//    TODO:
//    Show error when event is not saved because of validation
    //    Lineup each player only once: Chosenplayers are not removed
    
    var event: Event?
    var availablePlayers = ["Jos", "Mark", "Maurice", "Xavier", "Louis", "Els"]
    var chosenPlayers = Array<String>()
    var notChosenPlayers: Array<String> {
        set { }
        get { return availablePlayers.filter({ (player) -> Bool in
            return !chosenPlayers.contains(player)
        }) }
    }
    
    var positions = ["Loosehead prop", "Hooker", "Tighthead Prop"]
    
    struct FormItems {
        static let name = "name"
        static let type = "type"
        static let dateStart = "dateStart"
        static let dateEnd = "dateEnd"
        static let location = "location"
        static let description = "description"
    }
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
//    Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.updateSaveButtonState()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, HH:mm"
        
        form +++ Section("General information")
            // Name
            <<< TextRow(FormItems.name) { row in
                row.title = "Name"
                row.placeholder = "Event name"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnBlur
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = !row.isValid && row.wasBlurred ? .red : .black
                self.updateSaveButtonState()
            }
            
            // Description
            <<< TextAreaRow(FormItems.description) { row in
                row.title = "Description"
                row.placeholder = "Write here an optional description"
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = !row.isValid && row.wasBlurred ? .red : .black
                self.updateSaveButtonState()
            }
            
            // Address
            <<< TextRow(FormItems.location) { row in
                row.title = "Location"
                row.placeholder = "Write here"
            }
            .cellUpdate { cell, row in
                cell.titleLabel?.textColor = !row.isValid && row.wasBlurred ? .red : .black
                self.updateSaveButtonState()
            }
            
            // Event type
            <<< PickerInputRow<String>(FormItems.type) { row in
                row.title = "Type"
                row.options = ["Game", "Training", "Other"]
                row.add(rule: RuleRequired())
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = !row.isValid && row.wasBlurred ? .red : .black
                self.updateSaveButtonState()
            }
            
//        <<< SwitchRow("All-day") {
//            $0.title = $0.tag
//            }.onChange { [weak self] row in
//                let startDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Starts")
//                let endDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Ends")
//
//                if row.value ?? false {
//                    startDate.dateFormatter?.dateStyle = .medium
//                    startDate.dateFormatter?.timeStyle = .none
//                    endDate.dateFormatter?.dateStyle = .medium
//                    endDate.dateFormatter?.timeStyle = .none
//                }
//                else {
//                    startDate.dateFormatter?.dateStyle = .short
//                    startDate.dateFormatter?.timeStyle = .short
//                    endDate.dateFormatter?.dateStyle = .short
//                    endDate.dateFormatter?.timeStyle = .short
//                }
//                startDate.updateCell()
//                endDate.updateCell()
//                startDate.inlineRow?.updateCell()
//                endDate.inlineRow?.updateCell()
//            }
//
//            <<< DateTimeInlineRow("Starts") {
//                $0.title = $0.tag
//                $0.value = Date().addingTimeInterval(60*60*24)
//                }
//                .onChange { [weak self] row in
//                    let endRow: DateTimeInlineRow! = self?.form.rowBy(tag: "Ends")
//                    if row.value?.compare(endRow.value!) == .orderedDescending {
//                        endRow.value = Date(timeInterval: 60*60*24, since: row.value!)
//                        endRow.cell!.backgroundColor = .white
//                        endRow.updateCell()
//                    }
//                }
//                .onExpandInlineRow { [weak self] cell, row, inlineRow in
//                    inlineRow.cellUpdate() { cell, row in
//                        let allRow: SwitchRow! = self?.form.rowBy(tag: "All-day")
//                        if allRow.value ?? false {
//                            cell.datePicker.datePickerMode = .date
//                        }
//                        else {
//                            cell.datePicker.datePickerMode = .dateAndTime
//                        }
//                    }
//                    let color = cell.detailTextLabel?.textColor
//                    row.onCollapseInlineRow { cell, _, _ in
//                        cell.detailTextLabel?.textColor = color
//                    }
//                    cell.detailTextLabel?.textColor = cell.tintColor
//            }
//
//            <<< DateTimeInlineRow("Ends"){
//                $0.title = $0.tag
//                $0.value = Date().addingTimeInterval(60*60*25)
//                }
//                .onChange { [weak self] row in
//                    let startRow: DateTimeInlineRow! = self?.form.rowBy(tag: "Starts")
//                    if row.value?.compare(startRow.value!) == .orderedAscending {
//                        row.cell!.backgroundColor = .red
//                    }
//                    else{
//                        row.cell!.backgroundColor = .white
//                    }
//                    row.updateCell()
//                }
//                .onExpandInlineRow { [weak self] cell, row, inlineRow in
//                    inlineRow.cellUpdate { cell, dateRow in
//                        let allRow: SwitchRow! = self?.form.rowBy(tag: "All-day")
//                        if allRow.value ?? false {
//                            cell.datePicker.datePickerMode = .date
//                        }
//                        else {
//                            cell.datePicker.datePickerMode = .dateAndTime
//                        }
//                    }
//                    let color = cell.detailTextLabel?.textColor
//                    row.onCollapseInlineRow { cell, _, _ in
//                        cell.detailTextLabel?.textColor = color
//                    }
//                    cell.detailTextLabel?.textColor = cell.tintColor
//            }
            
            // Start date
            <<< DateTimeRow(FormItems.dateStart) { row in
                row.title = "Start date"
                row.add(rule: RuleRequired())
                let afterEndDateRule = RuleClosure<Date> { rowValue in
                    let endDate = (self.form.rowBy(tag: FormItems.dateEnd) as? DateTimeRow)?.value
                    if rowValue != nil, endDate != nil {
                        return endDate! > rowValue! ? nil : ValidationError(msg: "Start date should be before end date")
                    }
                    return nil
                }
                row.add(rule: afterEndDateRule)
                let dateInTheFuture = RuleClosure<Date> { rowValue in
                    if rowValue != nil {
                        return rowValue! > Date() ? nil : ValidationError(msg: "Date should be in the future")
                    }
                    return nil
                }
                row.add(rule: dateInTheFuture)
                row.dateFormatter = formatter
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = !row.isValid && row.wasBlurred ? .red : .black
                self.updateSaveButtonState()
            }
            
            // End date
            <<< DateTimeRow(FormItems.dateEnd) { row in
                row.title = "End date"
                row.add(rule: RuleRequired())
                let afterStartDateRule = RuleClosure<Date> { rowValue in
                    let startDate = (self.form.rowBy(tag: FormItems.dateStart) as? DateTimeRow)?.value
                    if rowValue != nil, startDate != nil {
                        return startDate! < rowValue! ? nil : ValidationError(msg: "End date should be after start date")
                    }
                    return nil
                }
                row.add(rule: afterStartDateRule)
                let dateInTheFuture = RuleClosure<Date> { rowValue in
                    if rowValue != nil {
                        return rowValue! > Date() ? nil : ValidationError(msg: "Date should be in the future")
                    }
                    return nil
                }
                row.add(rule: dateInTheFuture)
                row.dateFormatter = formatter
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = !row.isValid && row.wasBlurred ? .red : .black
                self.updateSaveButtonState()
            }
            
            // Lineup
            // TODO: IF TYPE IS GAME
            +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete, .Reorder],
                                   header: "Lineup",
                                   footer: "Click on add to add a player. Swipe to the right to delete a position") {
                $0.hidden = Condition.function([FormItems.type], { form in
                    !((form.rowBy(tag: FormItems.type) as? PickerInputRow)?.value == "Game")
                })
                
                $0 <<< SwitchRow("SwitchRow") { row in // initializer
                    row.title = "Lineup is private"
                }.onChange { row in
                    row.title = (row.value ?? false) ? "Lineup is public" : "Lineup is private"
                    row.updateCell()
                }
                
                $0.multivaluedRowToInsertAt = { index in
                    PushRow<String> {
                        // TODO: EDITABLE LABEL
                        $0.title = "\(index + 1)"
                        // AVAILABLE PLAYERS
                        $0.options = self.notChosenPlayers
                        }
                        .onChange { row in
                            if(row.value != nil && !self.chosenPlayers.contains(row.value!)){
                                self.chosenPlayers.append(row.value!)
                            }
                        }
                        .onCellSelection{ cell, row in
                            row.options = self.notChosenPlayers
                    }
                    
                }
                // default positions by team
                for position in self.positions {
                    $0 <<< PushRow<String> {
                        $0.title = position
                        $0.options = self.notChosenPlayers
                    }.onChange { row in
                            if(row.value != nil && !self.chosenPlayers.contains(row.value!)){
                                self.chosenPlayers.append(row.value!)
                            }
                        }.onCellSelection{ cell, row in
                            row.options = self.notChosenPlayers
                    }
                }
            }
        
        tableView?.isScrollEnabled = true
    }
    
    // Helpers
    private func updateSaveButtonState() {
        if form.isClean() {
            saveButton.isEnabled = false
        } else if form.validate().isEmpty {
            saveButton.isEnabled = true
        }
    }
    
    // Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        // ADDITIONAL CHECK IF FORM IS VALID
        if form.validate().isEmpty {
            let valuesDictionary = form.values()
            
            //EVENT UITBREIDEN!
            event = Event(startDate: valuesDictionary[FormItems.dateStart] as! Date, endDate: valuesDictionary[FormItems.dateEnd] as! Date, title: valuesDictionary[FormItems.name] as! String, description: valuesDictionary[FormItems.description] as! String, location: valuesDictionary[FormItems.location] as! String, type: valuesDictionary[FormItems.type] as! String)
        }
    }
}
