//
//  LoginViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 19/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import FirebaseUI
import CodableFirebase

var teamIdGlobal = "Test TEAM ID"

class LoginViewController: UIViewController {
    var ref: DatabaseReference!
    var user: User!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference().child("Users")
    }
    
    var handle : AuthStateDidChangeListenerHandle?
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is signed in
                print("Already logged in")
                self.performSegue(withIdentifier: "goHome", sender: self)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func emailLogInTapped(_ sender: Any) {
        // Get the default auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        //Set ourselves as delegate
        authUI?.delegate = self
        
        //get a reference to UI view controller
        let authViewController = authUI!.authViewController()
        
        //Present firebase UI
        present(authViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "additionalSetup" {
            let vc = segue.destination as! AdditionalSetupViewController
            vc.user = user
        }
    }

}

extension LoginViewController: FUIAuthDelegate {
    
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else{
            return
        }
        self.ref = Database.database().reference().child("Users")
        ref.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            if snapshot.hasChild((authDataResult?.user.uid)!) {
                self.performSegue(withIdentifier: "goHome", sender: self)
            } else {
                //User doesn't exist in DB
                //Add user to db
                self.user = User(name: (authDataResult?.user.displayName)!, id: (authDataResult?.user.uid)!)
                let data = try! FirebaseEncoder().encode(self.user)
                self.ref.child((authDataResult?.user.uid)!).setValue(data)
                
                //Additional required information
                self.performSegue(withIdentifier: "additionalSetup", sender: self)
            }
        })
        
        
    }
}
