//
//  To-Do_ViewController.swift
//  WHOOSH
//
//  Created by Aishwarya LED on 30/08/17.
//  Copyright © 2017 WHOOSHTODO. All rights reserved.
//

import UIKit

class To_Do_ViewController: UIViewController {
 @IBOutlet var menuButton:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
//        if revealViewController() != nil {
//                        revealViewController().rearViewRevealWidth = 150
//                        menuButton.target = revealViewController()
//                        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
//            //
//            //            revealViewController().rightViewRevealWidth = 150
//            //            extraButton.target = revealViewController()
//            //            extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
//            
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
        if self.revealViewController() != nil {
             revealViewController().rearViewRevealWidth = 240
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector((SWRevealViewController.revealToggle) as (SWRevealViewController) -> (Void) -> Void) // Swift 3 fix
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 240
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 240
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    @IBAction func toggleAction(_ sender: Any) {
        if revealViewController() != nil {
                        revealViewController().rearViewRevealWidth = 240
                        menuButton.target = revealViewController()
                        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
//                        revealViewController().rightViewRevealWidth = 150
//                        extraButton.target = revealViewController()
//                        extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       
    }
    
    @IBAction func addAction(_ sender: Any) {
         self.performSegue(withIdentifier: "newtask", sender: nil)
    }
    
    }


