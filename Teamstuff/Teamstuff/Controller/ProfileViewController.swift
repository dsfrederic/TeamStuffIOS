//
//  FirstViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 01/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import CodableFirebase
import Eureka

class ProfileViewController: FormViewController {
    
    var ref: DatabaseReference!
    var user: User?
    
    struct FormItems {
        static let name = "name"
        static let teamId = "teamId"
    }
    
//ONE TIME EXECUTED

    //    Work that depends on view being loaded and ready
    //    * updateUI
    //    * additional initizialization of views
    //    * network requests
    //    * db access
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        fetchUser()
        
        
        
        form +++ Section("Existing team")
            //            <<< ImageRow(FormItems.profileImage){
            //                $0.title = "Profile image (optional)"
            //            }
            
            <<< TextRow(FormItems.name){
                $0.title = "Name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            
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
                $0.title = "Submit"
                }.onCellSelection{ cell, row in
                    //SUBMIT
                    self.saveUser()
                }
            
            +++ Section()
            
            <<< ButtonRow(){
                $0.title = "Sign out"
                }.onCellSelection { cell, row in
                    let firebaseAuth = Auth.auth()
                    do {
                        try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                }
    }
    
    
//PERSISTENCE
    func saveUser(){
        if form.validate().isEmpty {
            let valuesDictionary = form.values()
            let teamId = valuesDictionary[FormItems.teamId] as? String
            ref.child("Teams").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if !snapshot.hasChild(teamId!){
                    print("Team not found")
                    let textrow = self.form.rowBy(tag: FormItems.teamId) as! TextRow
                    textrow.cell.titleLabel?.textColor = .red
                    textrow.cell.titleLabel?.text = "Team not found"
                    return
                }
                
                if(self.user == nil){
                    return
                }
                
                self.user!.teamId = teamId!
                let data = try! FirebaseEncoder().encode(self.user)
                self.ref.child("Users").child(self.user!.id).setValue(data)
            })
        }
    }
    
    func fetchUser() {
        ref.child("Users").child(Auth.auth().currentUser!.uid).observe(DataEventType.value, with: { (snapshot) in
            guard snapshot.value != nil else { return }
            do {
                let user : User = try FirebaseDecoder().decode(User.self, from: snapshot.value!)
                //            let user : User = snapshot.value as! User
                self.user = user
                teamIdGlobal = user.teamId!
            } catch let error {
                print(error)
            }
        })
    }
    
    
//MULTIPLE TIMES EXECUTED THROUGH LIFECYCLE
    
    //    Work that needs to be displayed every time this opens and can change
    //    * updateUI
    //    * adjusting to screen orientation
    //    * network requests
    
    var handle : AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                
            } else {
                //present new LoginViewController
                self.performSegue(withIdentifier: "returnToLoginProfile", sender: self)
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

    //    Place here if it takes a little bit longen to load...
    //    View will appear quicker
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Add code here
    }

    //
    //    * stop audio
    //    * stop notification observers...
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //Add code here
    }

}

