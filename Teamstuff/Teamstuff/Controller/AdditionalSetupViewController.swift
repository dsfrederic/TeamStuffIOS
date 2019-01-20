//
//  AdditionalSetupViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 19/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Firebase
import CodableFirebase


class AdditionalSetupViewController: FormViewController {
    
    var ref: DatabaseReference!
    var user: User!
    
    struct FormItems {
        static let profileImage = "profileImage"
        static let teamId = "teamId"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()

        // Do any additional setup after loading the view.
        
        form +++ Section("Existing team")
//            <<< ImageRow(FormItems.profileImage){
//                $0.title = "Profile image (optional)"
//            }
            
            <<< TextRow(FormItems.teamId){
                $0.title = "Team id"
                $0.add(rule: RuleRequired())
                let ruleOnlyLetters = RuleClosure<String> { rowValue in
                    if rowValue == nil {
                        return ValidationError(msg: "This field can't be empty")
                    }
                    return ((rowValue?.contains("."))! || (rowValue?.contains("]"))! || (rowValue?.contains("#"))! || (rowValue?.contains("$"))! || (rowValue?.contains("["))!) ? ValidationError(msg: "This field can't contain '.' '#' '$' '[' or ']'") : nil
                }
                $0.add(rule: ruleOnlyLetters)
                
                $0.validationOptions = .validatesOnChange
                
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            
            <<< ButtonRow(){
                $0.title = "Continue"
            }.onCellSelection{ cell, row in
                self.submit()
            }
        
            +++ Section("New team")
            
            <<< ButtonRow(){
                $0.title = "Create new team"
                }.onCellSelection{ cell, row in
                    self.submitNewTeam()
            }
    }
    
    func submit() {
        if form.validate().isEmpty {
            let valuesDictionary = form.values()
            let teamId = valuesDictionary[FormItems.teamId] as? String
            //TODO SET IMAGE
            ref.child("Teams").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if !snapshot.hasChild(teamId!){
                    print("Team not found")
                    let textrow = self.form.rowBy(tag: FormItems.teamId) as! TextRow
                    textrow.cell.titleLabel?.textColor = .red
                    textrow.cell.titleLabel?.text = "Team not found"
                    return
                }
                
                self.user.teamId = teamId!
                let data = try! FirebaseEncoder().encode(self.user)
                self.ref.child("Users").child(self.user.id).setValue(data)
                self.performSegue(withIdentifier: "goHomeAfterSetup", sender: self)
            })
        }
    }
    
    func submitNewTeam() {
            let teamKey = ref.child("Teams").childByAutoId().key
            //TODO SET IMAGE
            user.teamId = teamKey
            teamIdGlobal = teamKey!
            let data = try! FirebaseEncoder().encode(user)
            ref.child("Users").child(user.id).setValue(data)
        
            self.performSegue(withIdentifier: "goHomeAfterSetup", sender: self)
    }
}
