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

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var teamIdLabel: UILabel!
    var ref: DatabaseReference!
    var user: User?
    
    
//ONE TIME EXECUTED

    //    Work that depends on view being loaded and ready
    //    * updateUI
    //    * additional initizialization of views
    //    * network requests
    //    * db access
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let userId:String =  (Auth.auth().currentUser?.uid)!
        self.ref = Database.database().reference().child("Users").child(userId)
        fetchUser()
        
        welcomeLabel.text = "Welcome"
    }
    
    func fetchUser() {
        ref.observe(DataEventType.value, with: { (snapshot) in
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Add code here
        
        if(user != nil){
            welcomeLabel.text = "Welcome, " + String(user!.name)
        }
        teamIdLabel.text = teamIdGlobal
    }
    
//    Place here if it takes a little bit longen to load...
//    View will appear quicker
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Add code here
    }
    
    //    Back button, dismissing modal screen, ...
    //    * saving edits
    //    * hide keyboard
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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

