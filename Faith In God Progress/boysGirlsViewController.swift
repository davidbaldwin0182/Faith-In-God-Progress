//
//  boysGirlsViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/17/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class boysGirlsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ref = Database.database().reference(withPath: "User")
    let usersRef = Database.database().reference(withPath: "online")
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserUid = Auth.auth().currentUser?.uid
    var newUserUid = ""
    var buttonValBoys = ""
    var buttonValGirls = ""
    var myDocBoys = "myDocBoys"
    var myDocGirls = "myDocGirls"
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var imageBg: UIImageView!
    
    let boysGirls = [DataItemB(item: "1", name: "Uplifting and virtuous list", name2: "Restoration of the Aaronic Priesthood", message: "After studying the thirteenth article of faith, make a list of things that are uplifting and virtuous. Discuss with a parent or leader how you can seek after these things.",message2: "Learn about the restoration of the Aaronic Priesthood (see D&C 13, 107:20, and Joseph Smith—History 1:68–73).", checkMarked: "checkMark", checkValue: "false", index: 1, study: "", study2: "D&C 13\n\n 1 Upon you my fellow servants, in the name of Messiah I confer the Priesthood of Aaron, which holds the keys of the ministering of angels, and of the gospel of repentance, and of baptism by immersion for the remission of sins; and this shall never be taken again from the earth, until the sons of Levi do offer again an offering unto the Lord in righteousness.\n\n D&C 107:20\n\n 20 The power and authority of the lesser, or Aaronic Priesthood, is to hold the keys of the ministering of angels, and to administer in outward ordinances, the letter of the gospel, the baptism of repentance for the remission of sins, agreeable to the covenants and commandments.\n\n Joseph Smith - History 1:68-73\n\n 68 We still continued the work of translation, when, in the ensuing month (May, 1829), we on a certain day went into the woods to pray and inquire of the Lord respecting baptism for the remission of sins, that we found mentioned in the translation of the plates. While we were thus employed, praying and calling upon the Lord, a messenger from heaven descended in a cloud of light, and having laid his hands upon us, he ordained us, saying:\n\n 69 Upon you my fellow servants, in the name of Messiah, I confer the Priesthood of Aaron, which holds the keys of the ministering of angels, and of the gospel of repentance, and of baptism by immersion for the remission of sins; and this shall never be taken again from the earth until the sons of Levi do offer again an offering unto the Lord in righteousness.\n\n 70 He said this Aaronic Priesthood had not the power of laying on hands for the gift of the Holy Ghost, but that this should be conferred on us hereafter; and he commanded us to go and be baptized, and gave us directions that I should baptize Oliver Cowdery, and that afterwards he should baptize me.\n\n 71 Accordingly we went and were baptized. I baptized him first, and afterwards he baptized me—after which I laid my hands upon his head and ordained him to the Aaronic Priesthood, and afterwards he laid his hands on me and ordained me to the same Priesthood—for so we were commanded.\n\n 72 The messenger who visited us on this occasion and conferred this Priesthood upon us, said that his name was John, the same that is called John the Baptist in the New Testament, and that he acted under the direction of Peter, James and John, who held the keys of the Priesthood of Melchizedek, which Priesthood, he said, would in due time be conferred on us, and that I should be called the first Elder of the Church, and he (Oliver Cowdery) the second. It was on the fifteenth day of May, 1829, that we were ordained under the hand of this messenger, and baptized.\n\n 73 Immediately on our coming up out of the water after we had been baptized, we experienced great and glorious blessings from our Heavenly Father. No sooner had I baptized Oliver Cowdery, than the Holy Ghost fell upon him, and he stood up and prophesied many things which should shortly come to pass. And again, so soon as I had been baptized by him, I also had the spirit of prophecy, when, standing up, I prophesied concerning the rise of this Church, and many other things connected with the Church, and this generation of the children of men. We were filled with the Holy Ghost, and rejoiced in the God of our salvation."), DataItemB(item: "2", name: "Young Women program.", name2: "Aaronic Priesthood", message: "Talk with the Beehive class presidency or a member of the Young Women presidency about the purpose and importance of the Young Women program.", message2: "Read D&C 20:57–60 and Aaronic Priesthood: Fulfilling Our Duty to God [Deacon], page 7. Discuss with a parent or leader the purposes of the Aaronic Priesthood and what it means to do your duty to God.", checkMarked: "checkMark", checkValue: "false", index: 2, study: "", study2: "D & C 20:57-60\n\n 57 And is to be assisted always, in all his duties in the church, by the deacons, if occasion requires.\n\n 58 But neither teachers nor deacons have authority to baptize, administer the sacrament, or lay on hands;\n\n 59 They are, however, to warn, expound, exhort, and teach, and invite all to come unto Christ.\n\n 60 Every elder, priest, teacher, or deacon is to be ordained according to the gifts and callings of God unto him; and he is to be ordained by the power of the Holy Ghost, which is in the one who ordains him."), DataItemB(item: "3", name: "Stand for truth and righteousness.", name2: "Deacons quorum", message: "Write in your journal how you can serve the Lord as you stand for truth and righteousness.", message2: "Talk with the deacons quorum presidency about the role of the deacons quorum. Write in your journal how you can serve the Lord as a member of a deacons quorum.", checkMarked: "checkMark", checkValue: "false", index: 3, study: "", study2: ""), DataItemB(item: "4", name: "Importance of a good education", name2: "Importance of a good education", message: "Read D&C 88:77–80, 118 and D&C 130:19. Discuss with a parent or Primary leader how important a good education is and how it can help you strengthen your home and family and the Church.", message2: "Read D&C 88:77–80, 118 and D&C 130:19. Discuss with a parent or Primary leader how important a good education is and how it can help strengthen you as a priesthood holder in your home and family and in the Church.", checkMarked: "checkMark", checkValue: "false", index: 4, study: "D&C 88:77-80\n\n 77 And I give unto you a commandment that you shall teach one another the doctrine of the kingdom.\n\n78 Teach ye diligently and my grace shall attend you, that you may be instructed more perfectly in theory, in principle, in doctrine, in the law of the gospel, in all things that pertain unto the kingdom of God, that are expedient for you to understand;\n\n 79 Of things both in heaven and in the earth, and under the earth; things which have been, things which are, things which must shortly come to pass; things which are at home, things which are abroad; the wars and the perplexities of the nations, and the judgments which are on the land; and a knowledge also of countries and of kingdoms\n\n 80 That ye may be prepared in all things when I shall send you again to magnify the calling whereunto I have called you, and the mission with which I have commissioned you.\n\n D & C 118\n\n 118 And as all have not faith, seek ye diligently and teach one another words of wisdom; yea, seek ye out of the best books words of wisdom; seek learning, even by study and also by faith.\n\n D & C 130:19\n\n 19 And if a person gains more knowledge and intelligence in this life through his diligence and obedience than another, he will have so much the advantage in the world to come.", study2: "D & C 88:77-80\n\n 77 And I give unto you a commandment that you shall teach one another the doctrine of the kingdom.\n\n78 Teach ye diligently and my grace shall attend you, that you may be instructed more perfectly in theory, in principle, in doctrine, in the law of the gospel, in all things that pertain unto the kingdom of God, that are expedient for you to understand;\n\n 79 Of things both in heaven and in the earth, and under the earth; things which have been, things which are, things which must shortly come to pass; things which are at home, things which are abroad; the wars and the perplexities of the nations, and the judgments which are on the land; and a knowledge also of countries and of kingdoms\n\n 80 That ye may be prepared in all things when I shall send you again to magnify the calling whereunto I have called you, and the mission with which I have commissioned you.\n\n D & C 118\n\n 118 And as all have not faith, seek ye diligently and teach one another words of wisdom; yea, seek ye out of the best books words of wisdom; seek learning, even by study and also by faith.\n\n D & C 130:19\n\n 19 And if a person gains more knowledge and intelligence in this life through his diligence and obedience than another, he will have so much the advantage in the world to come."), DataItemB(item: "5", name: "A Proclamation to the World", name2: "A Proclamation to the World", message: "Read “The Family: A Proclamation to the World.” Make a list of things you can do to help strengthen your family and make a happy home. Share the list with your parents or Primary leader.", message2: "Read “The Family: A Proclamation to the World.” Make a list of things you can do to help strengthen your family and make a happy home. Share the list with your parents or Primary leader.", checkMarked: "checkMark", checkValue: "false", index: 5, study: "THE FAMILY\n\n A PROCLAMATION TO THE WORLD\n\n The First Presidency and Council of the Twelve Apostles of The Church of Jesus Christ of Latter-day Saints\n\n We, the First Presidency and the Council of the Twelve Apostles of The Church of Jesus Christ of Latter-day Saints, solemnly proclaim that marriage between a man and a woman is ordained of God and that the family is central to the Creator’s plan for the eternal destiny of His children.\n\n All human beings—male and female—are created in the image of God. Each is a beloved spirit son or daughter of heavenly parents, and, as such, each has a divine nature and destiny. Gender is an essential characteristic of individual premortal, mortal, and eternal identity and purpose.\n\n In the premortal realm, spirit sons and daughters knew and worshipped God as their Eternal Father and accepted His plan by which His children could obtain a physical body and gain earthly experience to progress toward perfection and ultimately realize their divine destiny as heirs of eternal life. The divine plan of happiness enables family relationships to be perpetuated beyond the grave. Sacred ordinances and covenants available in holy temples make it possible for individuals to return to the presence of God and for families to be united eternally.\n\n The first commandment that God gave to Adam and Eve pertained to their potential for parenthood as husband and wife. We declare that God’s commandment for His children to multiply and replenish the earth remains in force. We further declare that God has commanded that the sacred powers of procreation are to be employed only between man and woman, lawfully wedded as husband and wife.\n\n We declare the means by which mortal life is created to be divinely appointed. We affirm the sanctity of life and of its importance in God’s eternal plan.\n\n Husband and wife have a solemn responsibility to love and care for each other and for their children. “Children are an heritage of the Lord” (Psalm 127:3). Parents have a sacred duty to rear their children in love and righteousness, to provide for their physical and spiritual needs, and to teach them to love and serve one another, observe the commandments of God, and be law-abiding citizens wherever they live. Husbands and wives—mothers and fathers—will be held accountable before God for the discharge of these obligations.\n\n The family is ordained of God. Marriage between man and woman is essential to His eternal plan. Children are entitled to birth within the bonds of matrimony, and to be reared by a father and a mother who honor marital vows with complete fidelity. Happiness in family life is most likely to be achieved when founded upon the teachings of the Lord Jesus Christ. Successful marriages and families are established and maintained on principles of faith, prayer, repentance, forgiveness, respect, love, compassion, work, and wholesome recreational activities. By divine design, fathers are to preside over their families in love and righteousness and are responsible to provide the necessities of life and protection for their families. Mothers are primarily responsible for the nurture of their children. In these sacred responsibilities, fathers and mothers are obligated to help one another as equal partners. Disability, death, or other circumstances may necessitate individual adaptation. Extended families should lend support when needed.\n\n We warn that individuals who violate covenants of chastity, who abuse spouse or offspring, or who fail to fulfill family responsibilities will one day stand accountable before God. Further, we warn that the disintegration of the family will bring upon individuals, communities, and nations the calamities foretold by ancient and modern prophets.\n\n We call upon responsible citizens and officers of government everywhere to promote those measures designed to maintain and strengthen the family as the fundamental unit of society.", study2: "THE FAMILY\n\n A PROCLAMATION TO THE WORLD\n\n The First Presidency and Council of the Twelve Apostles of The Church of Jesus Christ of Latter-day Saints\n\n We, the First Presidency and the Council of the Twelve Apostles of The Church of Jesus Christ of Latter-day Saints, solemnly proclaim that marriage between a man and a woman is ordained of God and that the family is central to the Creator’s plan for the eternal destiny of His children.\n\n All human beings—male and female—are created in the image of God. Each is a beloved spirit son or daughter of heavenly parents, and, as such, each has a divine nature and destiny. Gender is an essential characteristic of individual premortal, mortal, and eternal identity and purpose.\n\n In the premortal realm, spirit sons and daughters knew and worshipped God as their Eternal Father and accepted His plan by which His children could obtain a physical body and gain earthly experience to progress toward perfection and ultimately realize their divine destiny as heirs of eternal life. The divine plan of happiness enables family relationships to be perpetuated beyond the grave. Sacred ordinances and covenants available in holy temples make it possible for individuals to return to the presence of God and for families to be united eternally.\n\n The first commandment that God gave to Adam and Eve pertained to their potential for parenthood as husband and wife. We declare that God’s commandment for His children to multiply and replenish the earth remains in force. We further declare that God has commanded that the sacred powers of procreation are to be employed only between man and woman, lawfully wedded as husband and wife.\n\n We declare the means by which mortal life is created to be divinely appointed. We affirm the sanctity of life and of its importance in God’s eternal plan.\n\n Husband and wife have a solemn responsibility to love and care for each other and for their children. “Children are an heritage of the Lord” (Psalm 127:3). Parents have a sacred duty to rear their children in love and righteousness, to provide for their physical and spiritual needs, and to teach them to love and serve one another, observe the commandments of God, and be law-abiding citizens wherever they live. Husbands and wives—mothers and fathers—will be held accountable before God for the discharge of these obligations.\n\n The family is ordained of God. Marriage between man and woman is essential to His eternal plan. Children are entitled to birth within the bonds of matrimony, and to be reared by a father and a mother who honor marital vows with complete fidelity. Happiness in family life is most likely to be achieved when founded upon the teachings of the Lord Jesus Christ. Successful marriages and families are established and maintained on principles of faith, prayer, repentance, forgiveness, respect, love, compassion, work, and wholesome recreational activities. By divine design, fathers are to preside over their families in love and righteousness and are responsible to provide the necessities of life and protection for their families. Mothers are primarily responsible for the nurture of their children. In these sacred responsibilities, fathers and mothers are obligated to help one another as equal partners. Disability, death, or other circumstances may necessitate individual adaptation. Extended families should lend support when needed.\n\n We warn that individuals who violate covenants of chastity, who abuse spouse or offspring, or who fail to fulfill family responsibilities will one day stand accountable before God. Further, we warn that the disintegration of the family will bring upon individuals, communities, and nations the calamities foretold by ancient and modern prophets.\n\n We call upon responsible citizens and officers of government everywhere to promote those measures designed to maintain and strengthen the family as the fundamental unit of society.")]

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
        return boysGirls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = boysGirls[indexPath.row]
        
        if buttonValGirls == "true" {
            cell.textLabel?.text = article.item
            cell.detailTextLabel?.text = article.name
        }
        if buttonValBoys == "true" {
            cell.textLabel?.text = article.item
            cell.detailTextLabel?.text = article.name2
        }
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
        if segue.identifier == "showYoungWomenDetail" {
            
            if let indexPath = self.tableViewOutlet.indexPathForSelectedRow {
                let navController = segue.destination as! UINavigationController
                let VC = navController.topViewController as! boysGirlsDetailViewController
                VC.selectedName = boysGirls[indexPath.row]
            }
        }
    }
}
