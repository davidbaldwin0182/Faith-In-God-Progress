//
//  tabViewController1.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/7/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class tabViewController1: UIViewController {
    
    let items: [UserData] = []
    var user: User!
    let toSingIn = "toSingIn"
    let toEVC = "toEVC"
    let ref = Database.database().reference(withPath: "User")
    let usersRef = Database.database().reference(withPath: "online")
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserUid = Auth.auth().currentUser?.uid
    var newUserUid = ""
    var newEmail = ""
    var myName = ""
    var docName = "myDocumentNameSave"
    var buttonValBoys = ""
    var buttonValGirls = ""
    var myDocBoys = "myDocBoys"
    var myDocGirls = "myDocGirls"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageBg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  

        

    }
    
    // Check value of button for boys / for girls / set background image
    override func viewWillAppear(_ animated: Bool) {
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        myName = show(document: docName, buttonValue: myName)
        if buttonValBoys == "true" {
            imageBg.image = UIImage(named:"faith_in_god_shield_lightblue")
        }
        if buttonValGirls == "true" {
            imageBg.image = UIImage(named:"faith_in_god_shield_lightpink")
        }
       // nameLabel.text = "USER"
        if let current = currentUserEmail {
            newEmail = current
        }
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let email = newEmail
        
        let userData = UserData(name: names, addedByUser: email, completed: false)
        
        let text = userData.name
        let userItemRef = self.ref.child((text.lowercased()))
        userItemRef.setValue(userData.toAnyObject())
        ref.observe(.value, with: { snapshot in
            var newItems: [UserData] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let userDataFile = UserData(snapshot: snapshot) {
                    newItems.removeAll()
                    newItems.append(userDataFile)
                }
            }
        })
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        show()
        myName = show(document: docName, buttonValue: myName)
        self.nameLabel.text = "\(self.myName)"
        if nameLabel.text == "" || buttonValBoys == "false" && buttonValGirls == "false" {
            self.performSegue(withIdentifier: self.toEVC, sender: nil)
        }
    }
    
    // Sign out of app
    @IBAction func signOutBtn(_ sender: Any) {
        let user = Auth.auth().currentUser!
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        onlineRef.removeValue { (error, _) in
            if let error = error {
                print("Removing online failed: \(error)")
                return
            }
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: self.toSingIn, sender: nil)
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Retrive user name
    func show() {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDoc = "myDocumentName\(names)"
        let fileManager = FileManager.default
        do {
            let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let url = documents.appendingPathComponent(myDoc).appendingPathExtension("txt")
            
            var readString = ""
            do {
                readString = try String(contentsOf: url)
                nameLabel.text = readString
            }
            catch {
                print("Error")
            }
        }
        catch {
            print("Error getting path")
        }
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
