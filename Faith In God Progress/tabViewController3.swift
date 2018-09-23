//
//  tabViewController3.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/8/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class tabViewController3: UIViewController {

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
    
    @IBOutlet weak var basicBtn: UIButton!
    @IBOutlet weak var learningBtn: UIButton!
    @IBOutlet weak var servingBtn: UIButton!
    @IBOutlet weak var talentsBtn: UIButton!
    @IBOutlet weak var preparingBtn: UIButton!
    @IBOutlet weak var imageBg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        if buttonValBoys == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightblue")
            preparingBtn.setTitle("Preparing For The Preisthood", for: .normal)
            basicBtn.backgroundColor = UIColor(displayP3Red: 128, green: 052, blue: 166, alpha: 0.8)
            learningBtn.backgroundColor = UIColor(displayP3Red: 128, green: 052, blue: 166, alpha: 0.8)
            servingBtn.backgroundColor = UIColor(displayP3Red: 128, green: 052, blue: 166, alpha: 0.8)
            talentsBtn.backgroundColor = UIColor(displayP3Red: 128, green: 052, blue: 166, alpha: 0.8)
            preparingBtn.backgroundColor = UIColor(displayP3Red: 128, green: 052, blue: 166, alpha: 0.8)
        }
        if buttonValGirls == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightpink")
            preparingBtn.setTitle("Preparing For Young Women", for: .normal)
            basicBtn.backgroundColor = UIColor(displayP3Red: 188, green: 122, blue: 166, alpha: 0.8)
            learningBtn.backgroundColor = UIColor(displayP3Red: 188, green: 122, blue: 166, alpha: 0.8)
            servingBtn.backgroundColor = UIColor(displayP3Red: 188, green: 122, blue: 166, alpha: 0.8)
            talentsBtn.backgroundColor = UIColor(displayP3Red: 188, green: 122, blue: 166, alpha: 0.8)
            preparingBtn.backgroundColor = UIColor(displayP3Red: 188, green: 122, blue: 166, alpha: 0.8)
        }
        if buttonValBoys == "" && buttonValGirls == "" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightblue")
            preparingBtn.setTitle("Edit Profile...\n Select for Boys or for Girls", for: .normal)
        }
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
}
