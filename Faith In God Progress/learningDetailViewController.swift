//
//  learningDetailViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/22/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class learningDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var selectedName: DataItemA?
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
    
    @IBOutlet weak var study: UIButton!
    @IBOutlet weak var note: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var imageBg: UIImageView!
    
    @IBOutlet weak var studyTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMessage()
        show()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CHECK", style: .plain, target: self, action: #selector(checkBtn(sender:)))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "checkMark")
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        if let indexed = selectedName?.index {
            let myArticle = "myDocL\(indexed)\(names)"
            getCheckValue(document: myArticle)
        }
        if buttonVal == "true" { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.green }
        else
        { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGray }
        notesTextView.isHidden = true
        studyTextView.isHidden = true
        message.isHidden = false
        let closeImage = UIImage(named: "close")
        let tintImage = closeImage?.withRenderingMode(.alwaysTemplate)
        cancel.setImage(tintImage, for: .normal)
        cancel.tintColor = UIColor.darkGray
        let saveImage = UIImage(named: "save")
        let tintImage2 = saveImage?.withRenderingMode(.alwaysTemplate)
        save.setImage(tintImage2, for: .normal)
        save.tintColor = UIColor.darkGray
        save.isHidden = true
        cancel.isHidden = true
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(myMethodToHandleTap(_:)))
        tap.delegate = self
        tap.numberOfTapsRequired = 1
        notesTextView.addGestureRecognizer(tap)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longGesture.minimumPressDuration = 0.4
        notesTextView.addGestureRecognizer(longGesture)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(myMethodToHandleTap2(_:)))
        tap2.delegate = self
        tap2.numberOfTapsRequired = 1
        studyTextView.addGestureRecognizer(tap2)
        let longGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(longPress2(_:)))
        longGesture.minimumPressDuration = 0.4
        studyTextView.addGestureRecognizer(longGesture2)
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        if buttonValBoys == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightblue")
        }
        if buttonValGirls == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightpink")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func updateMessage() {
        
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        if buttonValGirls == "true" {
            
            message.text = selectedName?.message
            studyTextView.text = selectedName?.study
            if selectedName?.study == "" {
                studyTextView.isHidden = true
                studyTextView.isSelectable = false
                study.isHidden = true
                study.isEnabled = false
            }
            else
            {
                studyTextView.isHidden = false
                studyTextView.isSelectable = true
                study.isHidden = false
                study.isEnabled = true
            }
        }
        if buttonValBoys == "true" {
            message.text = selectedName?.message
            studyTextView.text = selectedName?.study
            if selectedName?.study == "" {
                studyTextView.isHidden = true
                studyTextView.isSelectable = false
                study.isHidden = true
                study.isEnabled = false
            }
            else
            {
                studyTextView.isHidden = false
                studyTextView.isSelectable = true
                study.isHidden = false
                study.isEnabled = true
            }
        }
    }
    
    func animate(_ view: UIView, toHidden hidden: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 20, initialSpringVelocity: 5, options: UIView.AnimationOptions(), animations: { () -> Void in
            view.isHidden = hidden
        }, completion: nil)
    }
    
    @IBAction func cancelSave(_ sender: Any) {
        save.isHidden = true
        save.isEnabled = false
        cancel.isHidden = true
        cancel.isEnabled = false
        notesTextView.resignFirstResponder()
    }
    
    @IBAction func saveFileBtn(_ sender: Any) {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        if let indexed = selectedName?.index {
            let myDoc = "myDocumentLeaNote\(indexed)\(names).txt"
            
            let alertController = UIAlertController(title: "SAVE DOCUMENT", message: "", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                let fileManager = FileManager.default
                self.notesTextView.resignFirstResponder()
                do {
                    let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                    
                    let url = URL(string: myDoc, relativeTo: documents)
                    let stringToWrite = self.notesTextView.text
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
                self.notesTextView.resignFirstResponder()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            
            present(alertController, animated: true, completion: nil)
        }
        save.isHidden = true
        save.isEnabled = false
        cancel.isHidden = true
        cancel.isEnabled = false
        notesTextView.resignFirstResponder()
    }
    
    @IBAction func notesBtn(_ sender: Any) {
        if notesTextView.isHidden && studyTextView.isHidden
        {
            animate(notesTextView, toHidden: false)
            animate(message, toHidden: true)
        }
        else if notesTextView.isHidden && !studyTextView.isHidden
        {
            animate(notesTextView, toHidden: false)
            animate(studyTextView, toHidden: true)
        }
        else if !notesTextView.isHidden &&  studyTextView.isHidden
        {
            animate(notesTextView, toHidden: true)
            animate(message, toHidden: false)
            save.isHidden = true
            save.isEnabled = false
            cancel.isHidden = true
            cancel.isEnabled = false
            notesTextView.resignFirstResponder()
        }
    }
    
    @IBAction func studyBtn(_ sender: Any) {
        if notesTextView.isHidden && studyTextView.isHidden
        {
            animate(studyTextView, toHidden: false)
            animate(message, toHidden: true)
            studyTextView.scrollToTop()
            
        }
        else if notesTextView.isHidden && !studyTextView.isHidden
        {
            animate(studyTextView, toHidden: true)
            animate(message, toHidden: false)
            
        }
        else if !notesTextView.isHidden &&  studyTextView.isHidden
        {
            animate(notesTextView, toHidden: true)
            animate(studyTextView, toHidden: false)
            studyTextView.scrollToTop()
            save.isHidden = true
            save.isEnabled = false
            cancel.isHidden = true
            cancel.isEnabled = false
            notesTextView.resignFirstResponder()
        }
    }
    
    @objc func checkBtn(sender: UIBarButtonItem) {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        if let indexed = selectedName?.index {
            let myArticle = "myDocL\(indexed)\(names).txt"
            saveFile(document: myArticle)
            
            if buttonVal == "true" { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(red: 033, green: 225, blue: 023, alpha: 1) }
            else
            { self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGray }
        }
        viewDidLoad()
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            notesTextView.contentInset = UIEdgeInsets.zero
        } else {
            notesTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        notesTextView.scrollIndicatorInsets = notesTextView.contentInset
        let selectedRange = notesTextView.selectedRange
        notesTextView.scrollRangeToVisible(selectedRange)
    }
    
    @objc func myMethodToHandleTap(_ sender: UITapGestureRecognizer) {
        save.isHidden = false
        save.isEnabled = true
        cancel.isHidden = false
        cancel.isEnabled = true
        notesTextView.becomeFirstResponder()
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        save.isHidden = false
        save.isEnabled = true
        cancel.isHidden = false
        cancel.isEnabled = true
        notesTextView.becomeFirstResponder()
    }
    
    @objc func myMethodToHandleTap2(_ sender: UITapGestureRecognizer) {
        studyTextView.resignFirstResponder()
    }
    
    @objc func longPress2(_ sender: UILongPressGestureRecognizer) {
        studyTextView.resignFirstResponder()
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
    
    func show() {
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        if let indexed = selectedName?.index {
            let myDoc = "myDocumentLeaNote\(indexed)\(names)"
            
            let fileManager = FileManager.default
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let url = documents.appendingPathComponent(myDoc).appendingPathExtension("txt")
                
                var readString = ""
                do {
                    readString = try String(contentsOf: url)
                    notesTextView.text = readString
                }
                catch {
                    print("Error")
                }
            }
            catch {
                print("Error getting path")
            }
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

