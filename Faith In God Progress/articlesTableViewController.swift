//
//  articlesTableViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/10/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class articlesTableViewController: UITableViewController {
    
    let ref = Database.database().reference(withPath: "User")
    let usersRef = Database.database().reference(withPath: "online")
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserUid = Auth.auth().currentUser?.uid
    var newUserUid = ""
    var newEmail = ""
    var myDocFlipQuote = "myDocFlipQuote"
    var flipQuote = "true"
    
    let articles = [DataItemC(name: "Article of Faith 1", imageQuote: "articlesOfFaith1", imageBlank: "articlesOfFaith_1", checkMarked: "checkMark", checkValue: "false", index: 1), DataItemC(name: "Article of Faith 2", imageQuote: "articlesOfFaith2", imageBlank: "articlesOfFaith_2", checkMarked: "checkMark", checkValue: "false", index: 2), DataItemC(name: "Article of Faith 3", imageQuote: "articlesOfFaith3", imageBlank: "articlesOfFaith_3", checkMarked: "checkMark", checkValue: "false", index: 3), DataItemC(name: "Article of Faith 4", imageQuote: "articlesOfFaith4", imageBlank: "articlesOfFaith_4", checkMarked: "checkMark", checkValue: "false", index: 4), DataItemC(name: "Article of Faith 5", imageQuote: "articlesOfFaith5", imageBlank: "articlesOfFaith_5", checkMarked: "checkMark", checkValue: "false", index: 5), DataItemC(name: "Article of Faith 6", imageQuote: "articlesOfFaith6", imageBlank: "articlesOfFaith_6", checkMarked: "checkMark", checkValue: "false", index: 6), DataItemC(name: "Article of Faith 7", imageQuote: "articlesOfFaith7", imageBlank: "articlesOfFaith_7", checkMarked: "checkMark", checkValue: "false", index: 7), DataItemC(name: "Article of Faith 8", imageQuote: "articlesOfFaith8", imageBlank: "articlesOfFaith_8", checkMarked: "checkMark", checkValue: "false", index: 8), DataItemC(name: "Article of Faith 9", imageQuote: "articlesOfFaith9", imageBlank: "articlesOfFaith_9", checkMarked: "checkMark", checkValue: "false", index: 9), DataItemC(name: "Article of Faith 10", imageQuote: "articlesOfFaith10", imageBlank: "articlesOfFaith_10", checkMarked: "checkMark", checkValue: "false", index: 10), DataItemC(name: "Article of Faith 11", imageQuote: "articlesOfFaith11", imageBlank: "articlesOfFaith_11", checkMarked: "checkMark", checkValue: "false", index: 11), DataItemC(name: "Article of Faith 12", imageQuote: "articlesOfFaith12", imageBlank: "articlesOfFaith_12", checkMarked: "checkMark", checkValue: "false", index: 12), DataItemC(name: "Article of Faith 13", imageQuote: "articlesOfFaith13", imageBlank: "articlesOfFaith_13", checkMarked: "checkMark", checkValue: "false", index: 13)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        flipQuote = saveFile(document: myDocFlipQuote, buttonValue: flipQuote)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.name
        return cell
    }
    
    func saveFile(document: String, buttonValue: String) -> String {
        var myButtonVal = buttonValue
        
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDocument = "\(document)\(names).txt"
        var myString = "stringToWrite"
        
        if myButtonVal == "false" {
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
        return myString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
           
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let navController = segue.destination as! UINavigationController
                let VC = navController.topViewController as! articlesViewController
                VC.selectedName = articles[indexPath.row]
            }
        }
    }
}

