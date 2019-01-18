//
//  AddMessageViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 18/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import UITextView_Placeholder;

class AddMessageViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextView!
    
    var message : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.layer.borderColor = UIColor.gray.cgColor
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.cornerRadius = 4
        messageTextField.placeholder = "Enter message here..."
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        message = messageTextField.text
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        message = messageTextField.text
    }

}
