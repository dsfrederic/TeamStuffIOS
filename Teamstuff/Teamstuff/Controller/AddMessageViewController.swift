//
//  AddMessageViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 18/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit
import Eureka

class AddMessageViewController: FormViewController {
    
    var message : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            
            <<< TextAreaRow("Message") {
                $0.title = "Message"
                $0.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 96)
                $0.add(rule: RuleRequired())
                $0.placeholder = "Write here you're message"
            }
            
            <<< ButtonRow(){
                $0.title = "Submit"
                
                }.onCellSelection{ cell, row in
                    //SUBMIT
                    if self.form.validate().isEmpty {
                        self.performSegue(withIdentifier: "unwindToMessages", sender: self)
                    }
                }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let row: TextAreaRow? = form.rowBy(tag: "Message")
        let value : String = row!.value!
        
        message = value
    }

}
