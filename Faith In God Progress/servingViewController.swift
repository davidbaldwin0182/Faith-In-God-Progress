//
//  servingViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/17/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class servingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var imageBg: UIImageView!
    
    let serving = [DataItemA(item: "1", name: "Helping family or a neighbor", message: "Create and do a service project to help a family member or neighbor. Discuss how the service project helped your faith grow stronger after you have completed the project. Read and discuss the parable of the good Samaritan.\n Read: Luke 10:30–37", checkMarked: "checkMark", checkValue: "false", index: 1, study: "Luke 10:30-37\n\n 30 And Jesus answering said, A certain man went down from Jerusalem to Jericho, and fell among thieves, which stripped him of his raiment, and wounded him, and departed, leaving him half dead.\n\n 31 And by chance there came down a certain priest that way: and when he saw him, he passed by on the other side.\n\n 32 And likewise a Levite, when he was at the place, came and looked on him, and passed by on the other side.\n\n 33 But a certain Samaritan, as he journeyed, came where he was: and when he saw him, he had compassion on him,\n\n 34 And went to him, and bound up his wounds, pouring in oil and wine, and set him on his own beast, and brought him to an inn, and took care of him.\n\n 35 And on the morrow when he departed, he took out two pence, and gave them to the host, and said unto him, Take care of him; and whatsoever thou spendest more, when I come again, I will repay thee.\n\n 36 Which now of these three, thinkest thou, was neighbour unto him that fell among the thieves?\n\n 37 And he said, He that shewed mercy on him. Then said Jesus unto him, Go, and do thou likewise."), DataItemA(item: "2", name: "Write a letter of appreciation", message: "Write a letter to your parents, your grandparents, or a teacher, that tells what you appreciate and respect about them.", checkMarked: "checkMark", checkValue: "false", index: 2, study: ""), DataItemA(item: "3", name: "Develop qualities in yourself", message: "Create a list of the qualities you like in a person. Pick one quality to develop in yourself. Explain how showing kindness and respect strengthens you, your family, and others.", checkMarked: "checkMark", checkValue: "false", index: 3, study: ""), DataItemA(item: "4", name: "Serve a nutritious meal.", message: "Make and serve a nutritious meal.", checkMarked: "checkMark", checkValue: "false", index: 4, study: ""), DataItemA(item: "5", name: "Care for and nurture a young child.", message: "Entertain young children with games or songs you have learned or made yourself. Show that you understand how to nurture and care for a young child.", checkMarked: "checkMark", checkValue: "false", index: 5, study: ""), DataItemA(item: "6", name: "Manners and courtesy.", message: "Learn about and practice courtesy and good manners.", checkMarked: "checkMark", checkValue: "false", index: 6, study: ""), DataItemA(item: "7", name: "Parent-child activity", message: "Plan and hold a parent-child activity, such as a day trip, picnic, hike, dinner, or service project.", checkMarked: "checkMark", checkValue: "false", index: 7, study: ""), DataItemA(item: "8",name: "Being a good citizen", message: "Explain how your actions can affect others and what it means to be a good citizen, after reading the twelfth article of faith.", checkMarked: "checkMark", checkValue: "false", index: 8, study: ""), DataItemA(item: "9", name: "Help plan and carry out an activity.", message: "Help plan and carry out an upcoming quarterly activity with your Primary leaders.", checkMarked: "checkMark", checkValue: "false", index: 9, study: ""), DataItemA(item: "10", name: "Plan and complete your own activity", message: "Plan and complete your own activity to serve others.", checkMarked: "checkMark", checkValue: "false", index: 10, study: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serving.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = serving[indexPath.row]
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
        if segue.identifier == "showServingDetail" {
            
            if let indexPath = self.tableViewOutlet.indexPathForSelectedRow {
                let navController = segue.destination as! UINavigationController
                let VC = navController.topViewController as! servingDetailViewController
                VC.selectedName = serving[indexPath.row]
            }
        }
    }
}
