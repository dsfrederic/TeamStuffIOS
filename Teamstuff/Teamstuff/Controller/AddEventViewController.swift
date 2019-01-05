//
//  AddEventControllerViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 02/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import os.log


class AddEventViewController: UIViewController {
    
    var event: Event?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
//        let name = nameTextField.text ?? ""
//        let photo = photoImageView.image
//        let rating = ratingControl.rating
        
        event = Event(date: Date.init(), title: "Created")
    }

}
