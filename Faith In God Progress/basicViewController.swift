//
//  basicViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/17/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class basicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ref = Database.database().reference(withPath: "User")
    let usersRef = Database.database().reference(withPath: "online")
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserUid = Auth.auth().currentUser?.uid
    var newUserUid = ""
    var newEmail = ""
    var buttonValBoys = ""
    var buttonValGirls = ""
    var myDocBoys = "myDocBoys"
    var myDocGirls = "myDocGirls"
    
    @IBOutlet weak var basicTableView: UITableView!
    @IBOutlet weak var imageBg: UIImageView!
    
    let basics = [DataItemA(item: "1", name: "Prayer", message: "Daily prayer to Heavenly Father.", checkMarked: "checkMark", checkValue: "false", index: 1, study: ""), DataItemA(item: "2", name: "Studying scriptures", message: "Studying the scriptures regularly.", checkMarked: "checkMark", checkValue: "false", index: 2, study: ""), DataItemA(item: "3", name: "Keeping the commandments", message: "Keeping the commandments and living My Gospel Standards.", checkMarked: "checkMark", checkValue: "false", index: 3, study: ""), DataItemA(item: "4", name: "Honoring your parents", message: "Honoring your parents and be kind to your family.", checkMarked: "checkMark", checkValue: "false", index: 4, study: ""), DataItemA(item: "5", name: "Paying tithing", message: "Paying your tithing and attend tithing settlement.", checkMarked: "checkMark", checkValue: "false", index: 5, study: ""), DataItemA(item: "6", name: "Attending meetings ", message: "Attending sacrament meetings and Primary regularly.", checkMarked: "checkMark", checkValue: "false", index: 6, study: "")]
    
    override func viewDidLoad() {
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        if buttonValBoys == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightblue")
        }
        if buttonValGirls == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightpink")
            
        }
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basics.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = basics[indexPath.row]
        cell.textLabel?.text = article.item
        cell.detailTextLabel?.text = article.name
  
        return cell
    }
    
    func show(document: String, buttonValue: String) -> String {
        let fileManager = FileManager.default
        var myButtonValue = buttonValue
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDocument = "\(document)\(names)"
        do {
            let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let url = documents.appendingPathComponent(myDocument).appendingPathExtension("txt")
            
            do {
                var newString = ""
                newString = try String(contentsOf: url)
                myButtonValue = newString
            }
            catch {
                print("Error")
            }
        }
        catch {
            print("Error getting path")
        }
        return myButtonValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBasicDetail" {
            
            if let indexPath = self.basicTableView.indexPathForSelectedRow {
                let navController = segue.destination as! UINavigationController
                let VC = navController.topViewController as! basicDetailViewController
                VC.selectedName = basics[indexPath.row]
            }
        }
    }
}
