//
//  UploadViewController.swift
//  WHOOSH
//
//  Created by Aishwarya LED on 01/09/17.
//  Copyright © 2017 WHOOSHTODO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
class UploadViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    @IBOutlet weak var imagePicked: UIImageView!
    var ref:DatabaseReference?
    let selectedImage = UIImage()
    override func viewDidLoad() {
        imagePicked.layer.cornerRadius = imagePicked.frame.size.width / 2
        imagePicked.clipsToBounds = true
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion:{
                print("image ponda")
            })
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }
    @IBAction func saveButt(sender: AnyObject) {
         let userID = Auth.auth().currentUser!.uid
        let storageRef = Storage.storage().reference(forURL: "gs://whoosh-8eba2.appspot.com").child("profileImage").child(userID)
        if let uploadData = UIImagePNGRepresentation(self.imagePicked.image!) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                let profileimage = metadata?.downloadURL()?.absoluteString
                let ref = Database.database().reference()
                let userReferance = ref.child("users")
                let newuserRef = userReferance.child(userID)
                newuserRef.setValue(["profileImage": profileimage])
            })
            // completion((metadata?.downloadURL()?.absoluteString)!)!};)
            // your uploaded photo url.
        }
    }
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
       
        
            }
            
        }
        

