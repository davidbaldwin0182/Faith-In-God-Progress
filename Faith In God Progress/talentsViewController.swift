//
//  talentsViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/17/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class talentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    let talents = [DataItemA(item: "1", name: "Learn how to budget and save money", message: "Learn how to budget and save money. Discuss why it is important to faithfully pay our tithing and how Heavenly Father blesses us when we do (see 3 Nephi 24:10–11). Pay your tithing and begin saving for an education.", checkMarked: "checkMark", checkValue: "false", index: 1, study: "3 Nephi 24:10-11\n\n 10 Bring ye all the tithes into the storehouse, that there may be meat in my house; and prove me now herewith, saith the Lord of Hosts, if I will not open you the windows of heaven, and pour you out a blessing that there shall not be room enough to receive it.\n\n 11 And I will rebuke the devourer for your sakes, and he shall not destroy the fruits of your ground; neither shall your vine cast her fruit before the time in the fields, saith the Lord of Hosts."), DataItemA(item: "2", name: "Learn to sing, play, or lead a song", message: "Learn to sing, play, or lead a song from the Children’s Songbook. Teach or share the song in a family home evening or at Primary. Discuss how developing talents helps prepare us for service to Heavenly Father and others.", checkMarked: "checkMark", checkValue: "false", index: 2, study: ""), DataItemA(item: "3", name: "Write a poem, story, or short play", message: "Write a poem, story, or short play that teaches a principle of the gospel or is about Heavenly Father’s creations.", checkMarked: "checkMark", checkValue: "false", index: 3, study: ""), DataItemA(item: "4", name: "Make an item, or draw, paint, or sculpt", message: "Make an item from wood, metal, fabric, or other material, or draw, paint, or sculpt a piece of art. Display your finished work for others to see.", checkMarked: "checkMark", checkValue: "false", index: 4, study: ""),DataItemA(item: "5", name: "Visit an art museum or attend a concert, play", message: "Visit an art museum or attend a concert, play, or other cultural event. Share your experience with your family or activity day group.", checkMarked: "checkMark", checkValue: "false", index: 5, study: ""), DataItemA(item: "6", name: "Seek learning", message: "Read D&C 88:118. Discuss what it means to “seek learning, even by study and also by faith.” Improve your personal study habits by doing such things as learning how to choose and read good books or being prepared for school each day.", checkMarked: "checkMark", checkValue: "false", index: 6, study: "D&C 88:118\n\n 118 And as all have not faith, seek ye diligently and teach one another words of wisdom; yea, seek ye out of the best books words of wisdom; seek learning, even by study and also by faith."),DataItemA(item: "7", name: "Learning how to work.", message: "List five things you can do to help around your home. Discuss the importance of obeying and honoring your parents and learning how to work.", checkMarked: "checkMark", checkValue: "false", index: 7, study: ""), DataItemA(item: "8", name: "Physical fitness program", message: "Plan a physical fitness program for yourself that may include learning to play a sport or game. Participate in the program for one month.", checkMarked: "checkMark", checkValue: "false", index: 8, study: ""),DataItemA(item: "9", name: "good nutrition, health, and grooming", message: "Learn about and practice good nutrition, good health, and good grooming, including modest dress.", checkMarked: "checkMark", checkValue: "false", index: 9, study: ""), DataItemA(item: "10", name: "Develop your talents", message: "Plan and complete your own activity that will help you develop your talents (write the activity below).", checkMarked: "checkMark", checkValue: "false", index: 10, study: "")]

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
        return talents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = talents[indexPath.row]
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
        if segue.identifier == "showTalentsDetail" {
            
            if let indexPath = self.tableViewOutlet.indexPathForSelectedRow {
                let navController = segue.destination as! UINavigationController
                let VC = navController.topViewController as! talentsDetailViewController
                VC.selectedName = talents[indexPath.row]
            }
        }
    }
}
