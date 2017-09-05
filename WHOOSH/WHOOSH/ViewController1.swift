//
//  ViewController.swift
//  WHOOSH
//
//  Created by Aishwarya LED on 26/08/17.
//  Copyright © 2017 WHOOSHTODO. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelVersion: UILabel!
    override func viewDidLoad() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.labelVersion.text = "v\(version)"
        }
        UIView.transition(with: self.imageView,
                          duration: 3.0,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.imageView.image = UIImage(named: ("01_Splash@3x"))
        },
                          completion: { (finished: Bool) in
                            self.performSegue(withIdentifier: "Login", sender: self)})

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

