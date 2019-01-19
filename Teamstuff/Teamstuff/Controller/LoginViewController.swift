//
//  LoginViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 19/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else{
            return
        }
        
        
        
        //authDataResult?.user.uid
        performSegue(withIdentifier: "goHome", sender: self)
    }
}
