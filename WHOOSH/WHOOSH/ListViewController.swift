//
//  NewsTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
   
    @IBOutlet var extraButton:UIBarButtonItem!
    var number:[String] = [String]()
    var images:[UIImage] = [UIImage]()
    @IBOutlet weak var imageView: UIImageView!
    let cellReuseIdentifier = "cell"
    @IBOutlet var tableviews: UITableView!
    override func viewDidLoad() {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
      //  self.tableViews.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        super.viewDidLoad()
        number = ["To-Do","Scheduler","Notification","Profile","LogOut"]
        images = [#imageLiteral(resourceName: "list.png"),#imageLiteral(resourceName: "clock.png"),#imageLiteral(resourceName: "notification.png"),#imageLiteral(resourceName: "user.png"),#imageLiteral(resourceName: "logout.png")]
    }
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number.count
    }
    // create a cell for each table view row
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableviews.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
       cell.NameLabel.text = number[indexPath.row]
       cell.imageViews.image = images[indexPath.row]
        // set the text from the data model
      //  cell.textLabel?.text = self.animals[indexPath.row]
        return cell
    }
    // method to run when table view cell is tapped
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

    
    
      }
