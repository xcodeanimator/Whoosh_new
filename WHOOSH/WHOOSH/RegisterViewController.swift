//
//  RegisterViewController.swift
//  WHOOSH
//
//  Created by Aishwarya LED on 28/08/17.
//  Copyright © 2017 WHOOSHTODO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var confirmText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 8
        confirmText.layer.cornerRadius = 8
        emailText.layer.cornerRadius = 8
        emailText.delegate = self
        passwordText.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        confirmText.delegate = self
        passwordText.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func registerAction(_ sender: Any) {
        guard let username = emailText.text,
            username != "",
            let email = passwordText.text,
            email != "",
            let password = confirmText.text,
            password != ""
            else {
                let alert = UIAlertController(title: "Missing info", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        if email == password{
        Auth.auth().createUser(withEmail: username, password: password, completion: { (user, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            guard let user = user else { return }
            print(user.email ?? "MISSING EMAIL")
            print(user.uid)
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.emailText.text = ""
                    return
                }
                self.performSegue(withIdentifier: "retlogin", sender: nil)
            })
        })
        }else{
            let alert = UIAlertController(title: "Error", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func ReturnLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "retlogin", sender: self)
    }
    
}
