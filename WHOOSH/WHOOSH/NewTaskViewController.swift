//
//  NewTaskViewController.swift
//  WHOOSH
//
//  Created by Aishwarya LED on 31/08/17.
//  Copyright © 2017 WHOOSHTODO. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
@available(iOS 10.0, *)

 var dates: [Date] = [Date]()
class NewTaskViewController: UIViewController {

    @IBOutlet weak var priority: UITextField!
    @IBOutlet weak var selectDate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
      @IBAction func backAction(_ sender: Any) {
        self.performSegue(withIdentifier: "returnlist", sender: nil)
        
    }
    @IBAction func DoneAction(_ sender: Any) {
        self.performSegue(withIdentifier: "returnlist", sender: self)
    }
    
}
