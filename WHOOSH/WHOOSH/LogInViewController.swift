//
//  LogInViewController.swift
//  WHOOSH
//
//  Created by Aishwarya LED on 26/08/17.
//  Copyright © 2017 WHOOSHTODO. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import KeychainSwift
class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var forgotbutton: UIButton!
    @IBOutlet weak var actionAccount: UIButton!
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataService().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "showMain", sender: nil)
        }
    }
    func CompleteSignIn(id: String){
        let keyChain = DataService().keyChain
        keyChain.set(id , forKey: "uid")
    }
    override func viewDidLoad() {
        loginButton.layer.cornerRadius = 10
        emailText.layer.cornerRadius = 10
        passwordText.layer.cornerRadius = 10
        emailText.delegate = self
        passwordText.delegate = self
        actionAccount.layer.cornerRadius = 10
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
       
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
      
    }
    @IBAction func forgotAction(_ sender: Any) {
        let email = emailText.text!
       if emailText.text! != ""{
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if error == nil{
                let alert = UIAlertController(title: "Successull!", message: "Go to your Register Email", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
       }else{
        let alert = UIAlertController(title: "Error!", message: "Please Enter your Email id", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
         self.performSegue(withIdentifier: "register", sender: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
      
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailText == textField{
            passwordText.becomeFirstResponder()
        }
        else if passwordText == textField{
            if let email = emailText.text, let password = passwordText.text{
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if error == nil{
                      
                        self.performSegue(withIdentifier: "showMain", sender: self)
                    }
                    else {
                        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            if error != nil{
                                let alert = UIAlertController(title: "Log In Failed", message: "You Can't Login", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                self.emailText.text = ""
                                self.passwordText.text = ""
                            }
                            else{
                           
                                print("create New user")
                            }
                        }
                        //                    let alert = UIAlertController(title: "No Network Connection", message: "Please Check your Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                        //                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                        //                    self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    
    
        return true
    }
    @IBAction func logInAction(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil{
                     self.CompleteSignIn(id: user!.uid)
                    self.performSegue(withIdentifier: "showMain", sender: self)
                }
                else {
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if error != nil{
                            let alert = UIAlertController(title: "Log In Failed", message: "You Can't Login", preferredStyle: UIAlertControllerStyle.alert)
                                                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                                                self.present(alert, animated: true, completion: nil)
                        }
                        else{
                                 self.CompleteSignIn(id: user!.uid)
                            print("create New user")
                        }
                    }
//                    let alert = UIAlertController(title: "No Network Connection", message: "Please Check your Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
   }
