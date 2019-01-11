//
//  EventDetailViewController.swift
//  Teamstuff
//
//  Created by Frédéric De Smet on 11/01/2019.
//  Copyright © 2019 Frédéric De Smet. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event: Event = Event(date: Date.init(), title: "Dummy")
    var text: String = ""
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = event.title
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
