//
//  editProfileViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/31/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class editProfileViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "User")
    let usersRef = Database.database().reference(withPath: "online")
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserUid = Auth.auth().currentUser?.uid
    var newUserUid = ""
    var newEmail = ""
    let toVCProfile = "toVCProfile"
    var buttonValBoys = "false"
    var buttonValGirls = "false"
    var myDocBoys = "myDocBoys"
    var myDocGirls = "myDocGirls"
    var myDocName = "myDocName"
    var myName = "UserName"
    var docName = "myDocumentNameSave"
    
    @IBOutlet weak var imageBg: UIImageView!
    @IBOutlet weak var usersName: UITextField!
    @IBOutlet weak var faithForBoys: UIButton!
    @IBOutlet weak var faithForGirls: UIButton!
    
    // Dismiss keyboard
    @IBAction func dismissKeyBoard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
     // Check value of button for boys / for girls / set background image
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        myName = show(document: docName, buttonValue: myName)
        
        if buttonValBoys != "true" && buttonValGirls != "true" {
            
        }

        if buttonValBoys == "true" { faithForBoys.backgroundColor = UIColor.cyan
            imageBg.image = UIImage(named:"faith_in_god_shield_lightblue")
            
        }
        else
        { faithForBoys.backgroundColor = UIColor.clear }
        
        if buttonValGirls == "true" { faithForGirls.backgroundColor = UIColor.cyan
            imageBg.image = UIImage(named:"faith_in_god_shield_lightpink")
         
        }
        else
        { faithForGirls.backgroundColor = UIColor.clear }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Set app for boy user
    @IBAction func faithBoysBtn(_ sender: Any) {
        let myColorVal = UIColor.cyan
        faithForBoys.backgroundColor = myColorVal
        imageBg.image = UIImage(named:"faith_in_god_shield_lightblue")
        buttonValBoys = "true"
        faithForGirls.backgroundColor = UIColor.clear
        buttonValGirls = "false"
    }
    
    // Set app for girl user
    @IBAction func faithGirlsBtn(_ sender: Any) {
        let myColorVal = UIColor.cyan
        faithForGirls.backgroundColor = myColorVal
        imageBg.image = UIImage(named:"faith_in_god_shield_lightpink")
        buttonValGirls = "true"
        faithForBoys.backgroundColor = UIColor.clear
        buttonValBoys = "false"
    }
    
    // Save name and status boy or girl user for app
    @IBAction func saveProfile(_ sender: UIBarButtonItem) {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDoc = "myDocumentNameSave\(names).txt"
        let alertController = UIAlertController(title: "SAVE PROFILE", message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            let fileManager = FileManager.default
            self.usersName.resignFirstResponder()
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                
                let url = URL(string: myDoc, relativeTo: documents)
                let stringToWrite = self.usersName.text
                if let url = url {
                    try stringToWrite?.write(to:url, atomically: true, encoding: String.Encoding.utf8)
                    print(stringToWrite as Any)
                    let myColorVal = UIColor.cyan
                    self.buttonValBoys = self.saveFile(document: self.myDocBoys, buttonValue: self.buttonValBoys, boxColor: myColorVal, buttonAttribute: self.faithForBoys)
                    self.buttonValGirls = self.saveFile(document: self.myDocGirls, buttonValue: self.buttonValGirls, boxColor: myColorVal, buttonAttribute: self.faithForGirls)
                    self.performSegue(withIdentifier: self.toVCProfile, sender: nil)
                }
            }
            catch {
                print("Error getting path")
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            self.usersName.resignFirstResponder()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
        usersName.resignFirstResponder()
    }
    
    // Save status as boy or girl user
    func saveFile(document: String, buttonValue: String, boxColor: UIColor, buttonAttribute: UIButton) -> String {
        var myButtonVal = buttonValue
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDocument = "\(document)\(names).txt"
        var myString = "stringToWrite"
        let myColor = boxColor
        let myButtonAttribute = buttonAttribute
        
        if myButtonVal == "true" {
            let fileManager = FileManager.default
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let url = URL(string: myDocument, relativeTo: documents)
                myButtonVal = "true"
                myButtonAttribute.backgroundColor = myColor
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
                myButtonAttribute.backgroundColor = UIColor.clear
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
    
    // Retrive value true or false for boys / girls
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

}
