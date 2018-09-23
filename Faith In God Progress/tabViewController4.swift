//
//  tabViewController4.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/8/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class tabViewController4: UIViewController, UIGestureRecognizerDelegate {
    
    var progress: Progress?
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
    
    @IBOutlet weak var testimony: UITextView!
    @IBOutlet weak var imageBg: UIImageView!
    
    @objc func cancelBtn(sender: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItems?.last?.tintColor = UIColor.clear
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
        self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        testimony.resignFirstResponder()
    }
    
    @objc func saveBtn(sender: UIBarButtonItem) {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDoc = "myDocument\(names).txt"
        let alertController = UIAlertController(title: "SAVE DOCUMENT", message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            let fileManager = FileManager.default
            self.testimony.resignFirstResponder()
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                
                let url = URL(string: myDoc, relativeTo: documents)
                let stringToWrite = self.testimony.text
                if let url = url {
                    try stringToWrite?.write(to:url, atomically: true, encoding: String.Encoding.utf8)
                    print (documents)
                }
            }
            catch {
                print("Error getting path")
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            self.testimony.resignFirstResponder()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
        testimony.resignFirstResponder()
        self.navigationItem.rightBarButtonItems?.last?.tintColor = UIColor.clear
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
        self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    @objc func checkBtn(sender: UIBarButtonItem) {
        saveFile()
        viewWillAppear(false)
    }
    
    func saveFile(){
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDoc = "myDocT\(names).txt"
        
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        getCheckValue()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "CHECK", style: .plain, target: self, action: #selector(checkBtn(sender:))), UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveBtn(sender:)))]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelBtn(sender:)))
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "close")
        self.navigationItem.rightBarButtonItems?.first?.image = UIImage(named: "checkMark")
        self.navigationItem.rightBarButtonItems?.last?.image = UIImage(named: "save")
        
        if buttonVal == "true" { self.navigationItem.rightBarButtonItems?.first?.tintColor = UIColor.init(red: 033, green: 225, blue: 023, alpha: 1) }
        else
        { self.navigationItem.rightBarButtonItems?.first?.tintColor = UIColor.lightGray }
        
        self.navigationItem.rightBarButtonItems?.last?.tintColor = UIColor.clear
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
        self.navigationItem.rightBarButtonItems?.first?.isEnabled = true
        self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        show()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(myMethodToHandleTap(_:)))
        tap.delegate = self
        tap.numberOfTapsRequired = 1
        testimony.addGestureRecognizer(tap)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longGesture.minimumPressDuration = 0.4
        testimony.addGestureRecognizer(longGesture)
    }
    
    @objc func myMethodToHandleTap(_ sender: UITapGestureRecognizer) {
        self.navigationItem.rightBarButtonItems?.last?.tintColor = UIColor.darkGray
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        self.navigationItem.rightBarButtonItems?.last?.isEnabled = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "close")
        self.navigationItem.rightBarButtonItems?.last?.image = UIImage(named: "save")
        testimony.becomeFirstResponder()
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        self.navigationItem.rightBarButtonItems?.last?.tintColor = UIColor.darkGray
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        self.navigationItem.rightBarButtonItems?.last?.isEnabled = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "close")
        self.navigationItem.rightBarButtonItems?.last?.image = UIImage(named: "save")
        testimony.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            testimony.contentInset = UIEdgeInsets.zero
        } else {
            testimony.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        testimony.scrollIndicatorInsets = testimony.contentInset
        
        let selectedRange = testimony.selectedRange
        testimony.scrollRangeToVisible(selectedRange)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let current = currentUserEmail {
            newEmail = current
        }
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let email = newEmail
        print(names)
        print(email)
        getCheckValue()
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        if buttonValBoys == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightblue")
        }
        if buttonValGirls == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightpink")
            
        }
        
        if buttonVal == "true" { self.navigationItem.rightBarButtonItems?.first?.tintColor = UIColor.green }
        else
        { self.navigationItem.rightBarButtonItems?.first?.tintColor = UIColor.lightGray }
        
    }
    
    func show() {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDoc = "myDocument\(names)"
        let fileManager = FileManager.default
        do {
            let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let url = documents.appendingPathComponent(myDoc).appendingPathExtension("txt")
            
            var readString = ""
            do {
                readString = try String(contentsOf: url)
                testimony.text = readString
            }
            catch {
                print("Error")
            }
        }
        catch {
            print("Error getting path")
        }
    }
    
    func getCheckValue() {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDoc = "myDocT\(names)"
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
}
