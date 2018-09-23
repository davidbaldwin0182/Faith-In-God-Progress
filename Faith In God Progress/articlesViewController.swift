//
//  articlesViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/8/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class articlesViewController: UIViewController {
    
    var myArticle = articlesTableViewController()
    var selectedName: DataItemC?
    let ref = Database.database().reference(withPath: "User")
    let usersRef = Database.database().reference(withPath: "online")
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserUid = Auth.auth().currentUser?.uid
    var newUserUid = ""
    var newEmail = ""
    var buttonVal = ""
    var buttonValBoys = ""
    var buttonValGirls = ""
    var myDocBoys = "myDocBoys"
    var myDocGirls = "myDocGirls"
    var myDocFlipQuote = "myDocFlipQuote"
    var flipQuote = "true"
    
    @IBOutlet weak var imageBg: UIImageView!
    @IBOutlet weak var hideShow: UIButton!
    @IBOutlet weak var imageArticle: UIImageView!
    
    func updateImage() {
        if flipQuote == "true" {
        imageArticle.image = selectedName?.quote
        hideShow.setTitle("Hide Article", for: .normal)
        }
        else
        {
        imageArticle.image = selectedName?.blank
        hideShow.setTitle("Show Article", for: .normal)
        }
    }
    
    @objc func checkBtn(sender: UIBarButtonItem) {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        if let indexed = selectedName?.index {
        let myArticle = "myDocA\(indexed)\(names).txt"
        saveFile(document: myArticle)
 
        if buttonVal == "true" { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 033, green: 225, blue: 023, alpha: 1) }
        else
        { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGray }
    }
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CHECK", style: .plain, target: self, action: #selector(checkBtn(sender:)))
        
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "checkMark")
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        if let indexed = selectedName?.index {
            let myArticle = "myDocA\(indexed)\(names)"
            getCheckValue(document: myArticle)
        
        }
        if buttonVal == "true" { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.green }
        else
        { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGray }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        flipQuote = show(document: myDocFlipQuote, buttonValue: flipQuote)
        updateImage()
        if let current = currentUserEmail {
            newEmail = current
        }
        if let current = currentUserUid {
            newUserUid = current
        }
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        if buttonValBoys == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightblue")
        }
        if buttonValGirls == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightpink")
            
        }
    }
    
    @IBAction func flipCard(_ sender: Any) {

        flipQuote = saveFile(document: myDocFlipQuote, buttonValue: flipQuote)
    }
    
    func saveFile(document: String){
        let myDoc = document
        
        if buttonVal != "true" {
            let fileManager = FileManager.default
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let url = URL(string: myDoc, relativeTo: documents)
                let myButtonVal = "true"
                let stringToWrite = myButtonVal
                if let url = url {
                    try stringToWrite.write(to:url, atomically: true, encoding: String.Encoding.utf8)
                }
            }
            catch {
                print("Error getting path")
            }
        }
        else
        {
            let fileManager = FileManager.default
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let url = URL(string: myDoc, relativeTo: documents)
                let myButtonVal = "false"
                let stringToWrite = myButtonVal
                if let url = url {
                    try stringToWrite.write(to:url, atomically: true, encoding: String.Encoding.utf8)
                }
            }
            catch {
                print("Error getting path")
            }
        }
    }
    
    func getCheckValue(document: String) {
        let myDoc = document
        let fileManager = FileManager.default
        do {
            let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let url = documents.appendingPathComponent(myDoc).appendingPathExtension("txt")
            do {
                let newString = try String(contentsOf: url)
                buttonVal = newString
            }
            catch {
                print("Error")
            }
        }
        catch {
            print("Error getting path")
        }
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
        if segue.identifier == "showDetailSwitch" {
            
            if let indexPath = selectedName {
                let navController = segue.destination as! UINavigationController
                let VC = navController.topViewController as! articlesViewController
                VC.selectedName = indexPath
                
            }
        }
    }
    
    // Save status of check box
    func saveFile(document: String, buttonValue: String) -> String {
        var myButtonVal = buttonValue
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDocument = "\(document)\(names).txt"
        var myString = "stringToWrite"
        
        if myButtonVal != "true" {
            let fileManager = FileManager.default
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let url = URL(string: myDocument, relativeTo: documents)
                myButtonVal = "true"
                myString = myButtonVal
                if let url = url {
                    try myString.write(to:url, atomically: true, encoding: String.Encoding.utf8)
                }
            }
            catch {
                print("Error getting path")
            }
        }
        else
        {
            let fileManager = FileManager.default
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let url = URL(string: myDocument, relativeTo: documents)
                myButtonVal = "false"
                myString = myButtonVal
                if let url = url {
                    try myString.write(to:url, atomically: true, encoding: String.Encoding.utf8)
                }
            }
            catch {
                print("Error getting path")
            }
        }
        return myString
    }
}
