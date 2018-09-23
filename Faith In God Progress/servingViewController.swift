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
    
    let serving = [DataItemA(item: "1", name: "Help a family member or neighbor", message: "Read and discuss the parable of the good Samaritan (see Luke 10:30–37). Plan and complete a service project that helps a family member or neighbor. After completing the project, discuss how it helped your faith grow stronger.", checkMarked: "checkMark", checkValue: "false", index: 1, study: "Luke 10:30-37\n\n 30 And Jesus answering said, A certain man went down from Jerusalem to Jericho, and fell among thieves, which stripped him of his raiment, and wounded him, and departed, leaving him half dead.\n\n 31 And by chance there came down a certain priest that way: and when he saw him, he passed by on the other side.\n\n 32 And likewise a Levite, when he was at the place, came and looked on him, and passed by on the other side.\n\n 33 But a certain Samaritan, as he journeyed, came where he was: and when he saw him, he had compassion on him,\n\n 34 And went to him, and bound up his wounds, pouring in oil and wine, and set him on his own beast, and brought him to an inn, and took care of him.\n\n 35 And on the morrow when he departed, he took out two pence, and gave them to the host, and said unto him, Take care of him; and whatsoever thou spendest more, when I come again, I will repay thee.\n\n 36 Which now of these three, thinkest thou, was neighbour unto him that fell among the thieves?\n\n 37 And he said, He that shewed mercy on him. Then said Jesus unto him, Go, and do thou likewise."), DataItemA(item: "2", name: "Write a letter of appreciation", message: "Write a letter to a teacher, your parents, or your grandparents telling them what you appreciate and respect about them.", checkMarked: "checkMark", checkValue: "false", index: 2, study: ""), DataItemA(item: "3", name: "Develop qualities in yourself", message: "Make a list of the qualities you like in a person. Choose one quality to develop in yourself. Discuss how showing respect and kindness strengthens you, your family, and others.", checkMarked: "checkMark", checkValue: "false", index: 3, study: ""), DataItemA(item: "4", name: "Serve a nutritious meal.", message: "Plan, prepare, and serve a nutritious meal.", checkMarked: "checkMark", checkValue: "false", index: 4, study: ""), DataItemA(item: "5", name: "Care for and nurture a young child.", message: "Entertain young children with songs or games you have learned or made yourself. Show that you know how to care for and nurture a young child.", checkMarked: "checkMark", checkValue: "false", index: 5, study: ""), DataItemA(item: "6", name: "Manners and courtesy.", message: "Learn about and practice good manners and courtesy.", checkMarked: "checkMark", checkValue: "false", index: 6, study: ""), DataItemA(item: "7", name: "Parent-child activity", message: "Plan and hold a parent-child activity, such as a dinner, picnic, hike, day trip, or service project.", checkMarked: "checkMark", checkValue: "false", index: 7, study: ""), DataItemA(item: "8",name: "Being a good citizen", message: "Read the twelfth article of faith. Discuss what it means to be a good citizen and how your actions can affect others.", checkMarked: "checkMark", checkValue: "false", index: 8, study: ""), DataItemA(item: "9", name: "Help plan and carry out an activity.", message: "Help your Primary leaders plan and carry out an upcoming quarterly activity.", checkMarked: "checkMark", checkValue: "false", index: 9, study: ""), DataItemA(item: "10", name: "Plan and complete your own activity", message: "Plan and complete your own activity to serve others (write the activity below).", checkMarked: "checkMark", checkValue: "false", index: 10, study: "")]
    
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
