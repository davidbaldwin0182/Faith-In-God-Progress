//
//  learningViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/17/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class learningViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    let learning = [DataItemA(item: "1", name: "Sacrament and baptismal covenant", message: "Explain how it helps to renew your baptismal covenant when you take the sacrament. Teach others during a family home evening, about things we can do to keep faithful.", checkMarked: "checkMark", checkValue: "false", index: 1, study: ""), DataItemA(item: "2", name: "Heavenly Father answers our prayers.", message: "In a family home evening, give a lesson on Joseph Smith’s First Vision.\n Discuss how our sincere prayers are answered by our Hevenly Father.\n Read: Joseph Smith-History 1:1-20", checkMarked: "checkMark", checkValue: "false", index: 2, study: "Joseph Smith-History 1:1-20\n\n 1 Owing to the many reports which have been put in circulation by evil-disposed and designing persons, in relation to the rise and progress of The Church of Jesus Christ of Latter-day Saints, all of which have been designed by the authors thereof to militate against its character as a Church and its progress in the world—I have been induced to write this history, to disabuse the public mind, and put all inquirers after truth in possession of the facts, as they have transpired, in relation both to myself and the Church, so far as I have such facts in my possession.\n\n 2 In this history I shall present the various events in relation to this Church, in truth and righteousness, as they have transpired, or as they at present exist, being now [1838] the eighth year since the organization of the said Church.\n\n  3 I was born in the year of our Lord one thousand eight hundred and five, on the twenty-third day of December, in the town of Sharon, Windsor county, State of Vermont. … My father, Joseph Smith, Sen., left the State of Vermont, and moved to Palmyra, Ontario (now Wayne) county, in the State of New York, when I was in my tenth year, or thereabouts. In about four years after my father’s arrival in Palmyra, he moved with his family into Manchester in the same county of Ontario\n\n 4 His family consisting of eleven souls, namely, my father, Joseph Smith; my mother, Lucy Smith (whose name, previous to her marriage, was Mack, daughter of Solomon Mack); my brothers, Alvin (who died November 19th, 1823, in the 26th year of his age), Hyrum, myself, Samuel Harrison, William, Don Carlos; and my sisters, Sophronia, Catherine, and Lucy.\n\n 5 Some time in the second year after our removal to Manchester, there was in the place where we lived an unusual excitement on the subject of religion. It commenced with the Methodists, but soon became general among all the sects in that region of country. Indeed, the whole district of country seemed affected by it, and great multitudes united themselves to the different religious parties, which created no small stir and division amongst the people, some crying, “Lo, here!” and others, “Lo, there!” Some were contending for the Methodist faith, some for the Presbyterian, and some for the Baptist.\n\n 6 For, notwithstanding the great love which the converts to these different faiths expressed at the time of their conversion, and the great zeal manifested by the respective clergy, who were active in getting up and promoting this extraordinary scene of religious feeling, in order to have everybody converted, as they were pleased to call it, let them join what sect they pleased; yet when the converts began to file off, some to one party and some to another, it was seen that the seemingly good feelings of both the priests and the converts were more pretended than real; for a scene of great confusion and bad feeling ensued—priest contending against priest, and convert against convert; so that all their good feelings one for another, if they ever had any, were entirely lost in a strife of words and a contest about opinions.\n\n 7 I was at this time in my fifteenth year. My father’s family was proselyted to the Presbyterian faith, and four of them joined that church, namely, my mother, Lucy; my brothers Hyrum and Samuel Harrison; and my sister Sophronia.\n\n 8 During this time of great excitement my mind was called up to serious reflection and great uneasiness; but though my feelings were deep and often poignant, still I kept myself aloof from all these parties, though I attended their several meetings as often as occasion would permit. In process of time my mind became somewhat partial to the Methodist sect, and I felt some desire to be united with them; but so great were the confusion and strife among the different denominations, that it was impossible for a person young as I was, and so unacquainted with men and things, to come to any certain conclusion who was right and who was wrong.\n\n 9 My mind at times was greatly excited, the cry and tumult were so great and incessant. The Presbyterians were most decided against the Baptists and Methodists, and used all the powers of both reason and sophistry to prove their errors, or, at least, to make the people think they were in error. On the other hand, the Baptists and Methodists in their turn were equally zealous in endeavoring to establish their own tenets and disprove all others.\n\n 10 In the midst of this war of words and tumult of opinions, I often said to myself: What is to be done? Who of all these parties are right; or, are they all wrong together? If any one of them be right, which is it, and how shall I know it?\n\n 11 While I was laboring under the extreme difficulties caused by the contests of these parties of religionists, I was one day reading the Epistle of James, first chapter and fifth verse, which reads: If any of you lack wisdom, let him ask of God, that giveth to all men liberally, and upbraideth not; and it shall be given him.\n\n 12 Never did any passage of scripture come with more power to the heart of man than this did at this time to mine. It seemed to enter with great force into every feeling of my heart. I reflected on it again and again, knowing that if any person needed wisdom from God, I did; for how to act I did not know, and unless I could get more wisdom than I then had, I would never know; for the teachers of religion of the different sects understood the same passages of scripture so differently as to destroy all confidence in settling the question by an appeal to the Bible.\n\n 13 At length I came to the conclusion that I must either remain in darkness and confusion, or else I must do as James directs, that is, ask of God. I at length came to the determination to “ask of God,” concluding that if he gave wisdom to them that lacked wisdom, and would give liberally, and not upbraid, I might venture.\n\n 14 So, in accordance with this, my determination to ask of God, I retired to the woods to make the attempt. It was on the morning of a beautiful, clear day, early in the spring of eighteen hundred and twenty. It was the first time in my life that I had made such an attempt, for amidst all my anxieties I had never as yet made the attempt to pray vocally.\n\n 15 After I had retired to the place where I had previously designed to go, having looked around me, and finding myself alone, I kneeled down and began to offer up the desires of my heart to God. I had scarcely done so, when immediately I was seized upon by some power which entirely overcame me, and had such an astonishing influence over me as to bind my tongue so that I could not speak. Thick darkness gathered around me, and it seemed to me for a time as if I were doomed to sudden destruction.\n\n 16 But, exerting all my powers to call upon God to deliver me out of the power of this enemy which had seized upon me, and at the very moment when I was ready to sink into despair and abandon myself to destruction—not to an imaginary ruin, but to the power of some actual being from the unseen world, who had such marvelous power as I had never before felt in any being—just at this moment of great alarm, I saw a pillar of light exactly over my head, above the brightness of the sun, which descended gradually until it fell upon me.\n\n 17 It no sooner appeared than I found myself delivered from the enemy which held me bound. When the light rested upon me I saw two Personages, whose brightness and glory defy all description, standing above me in the air. One of them spake unto me, calling me by name and said, pointing to the other—This is My Beloved Son. Hear Him!\n\n 18 My object in going to inquire of the Lord was to know which of all the sects was right, that I might know which to join. No sooner, therefore, did I get possession of myself, so as to be able to speak, than I asked the Personages who stood above me in the light, which of all the sects was right (for at this time it had never entered into my heart that all were wrong)—and which I should join.\n\n 19 I was answered that I must join none of them, for they were all wrong; and the Personage who addressed me said that all their creeds were an abomination in his sight; that those professors were all corrupt; that: “they draw near to me with their lips, but their hearts are far from me, they teach for doctrines the commandments of men, having a form of godliness, but they deny the power thereof.”\n\n 20 He again forbade me to join with any of them; and many other things did he say unto me, which I cannot write at this time. When I came to myself again, I found myself lying on my back, looking up into heaven. When the light had departed, I had no strength; but soon recovering in some degree, I went home. And as I leaned up to the fireplace, mother inquired what the matter was. I replied, “Never mind, all is well—I am well enough off.” I then said to my mother, “I have learned for myself that Presbyterianism is not true.” It seems as though the adversary was aware, at a very early period of my life, that I was destined to prove a disturber and an annoyer of his kingdom; else why should the powers of darkness combine against me? Why the opposition and persecution that arose against me, almost in my infancy?"), DataItemA(item: "3", name: "How the Holy Ghost helps you.", message: "Highlight verses John 14:16–17, 2 Nephi 32:5 and Moroni 10:5 in your scriptures about the Holy Ghost\n Explain how the Holy Ghost helps you.", checkMarked: "checkMark", checkValue: "false", index: 3, study: "John 14:16–17\n\n 16 And I will pray the Father, and he shall give you another Comforter, that he may abide with you for ever.\n\n  17 Even the Spirit of truth; whom the world cannot receive, because it seeth him not, neither knoweth him: but ye know him; for he dwelleth with you, and shall be in you.\n\n 2 Nephi 32:5\n\n 5 For behold, again I say unto you that if ye will enter in by the way, and receive the Holy Ghost, it will show unto you all things what ye should do.\n\n Moroni 10:5\n\n 5 And by the power of the Holy Ghost ye may know the truth of all things."), DataItemA(item: "4", name: "Follow the prophet", message: "Study a recent conference address from the prophet. Decide how you can follow the prophet, and follow through with it.", checkMarked: "checkMark", checkValue: "false", index: 4, study: ""), DataItemA(item: "5", name: "Prayer protects us", message: "In a family home evening or during Primary, give an opening and a closing prayer. Share how prayer protects us and keeps us close to our Heavenly Father and the Savior.", checkMarked: "checkMark", checkValue: "false", index: 5, study: ""), DataItemA(item: "6", name: "Faith in Jesus Christ", message: "Share a story that teaches about faith in Jesus Christ from the Book of Mormon. Share your testimony of Jesus Christ.", checkMarked: "checkMark", checkValue: "false", index: 6, study: ""), DataItemA(item: "7", name: "Word of Wisdom", message: "Explain how our Heavenly Father blesses us as we are living the Word of Wisdom faithfully. Help create an activity that teaches the Word of Wisdom to others.\n Read D&C 89.", checkMarked: "checkMark", checkValue: "false", index: 7, study: "D&C 89\n\n 1 A Word of Wisdom, for the benefit of the council of high priests, assembled in Kirtland, and the church, and also the saints in Zion\n\n 2 To be sent greeting; not by commandment or constraint, but by revelation and the word of wisdom, showing forth the order and will of God in the temporal salvation of all saints in the last days\n\n 3 Given for a principle with promise, adapted to the capacity of the weak and the weakest of all saints, who are or can be called saints.\n\n 4 Behold, verily, thus saith the Lord unto you: In consequence of evils and designs which do and will exist in the hearts of conspiring men in the last days, I have warned you, and forewarn you, by giving unto you this word of wisdom by revelation\n\n 5 That inasmuch as any man drinketh wine or strong drink among you, behold it is not good, neither meet in the sight of your Father, only in assembling yourselves together to offer up your sacraments before him.\n\n 6 And, behold, this should be wine, yea, pure wine of the grape of the vine, of your own make.\n\n 7 And, again, strong drinks are not for the belly, but for the washing of your bodies.\n\n 8 And again, tobacco is not for the body, neither for the belly, and is not good for man, but is an herb for bruises and all sick cattle, to be used with judgment and skill.\n\n 9 And again, hot drinks are not for the body or belly.\n\n 10 And again, verily I say unto you, all wholesome herbs God hath ordained for the constitution, nature, and use of man\n\n 11 Every herb in the season thereof, and every fruit in the season thereof; all these to be used with prudence and thanksgiving.\n\n 12 Yea, flesh also of beasts and of the fowls of the air, I, the Lord, have ordained for the use of man with thanksgiving; nevertheless they are to be used sparingly.\n\n 13 And it is pleasing unto me that they should not be used, only in times of winter, or of cold, or famine.\n\n 14 All grain is ordained for the use of man and of beasts, to be the staff of life, not only for man but for the beasts of the field, and the fowls of heaven, and all wild animals that run or creep on the earth.\n\n 15 And these hath God made for the use of man only in times of famine and excess of hunger.\n\n 16 All grain is good for the food of man; as also the fruit of the vine; that which yieldeth fruit, whether in the ground or above the ground\n\n 17 Nevertheless, wheat for man, and corn for the ox, and oats for the horse, and rye for the fowls and for swine, and for all beasts of the field, and barley for all useful animals, and for mild drinks, as also other grain.\n\n 18 And all saints who remember to keep and do these sayings, walking in obedience to the commandments, shall receive health in their navel and marrow to their bones.\n\n 19 And shall find wisdom and great treasures of knowledge, even hidden treasures.\n\n 20 And shall run and not be weary, and shall walk and not faint.\n\n 21 And I, the Lord, give unto them a promise, that the destroying angel shall pass by them, as the children of Israel, and not slay them. Amen."), DataItemA(item: "8", name: "Temple work", message: "Create a pedigree chart that has your name and your parents’ and grandparents’ names. Share a family story and make a family group record for your family. Discuss how it blesses families by performing temple work.", checkMarked: "checkMark", checkValue: "false", index: 8, study: ""), DataItemA(item: "9", name: "Choose the Right", message: "Learn to sing (Hymns, no. 239) “Choose the Right”. Discuss what it means to be responsible for your choices and what agency is. Explain how it has helped you develop greater faith by making good choices.", checkMarked: "checkMark", checkValue: "false", index: 9, study: ""), DataItemA(item: "10", name: "Learning and living the gospel", message: "Create your own activity that will help you live and learn the gospel.", checkMarked: "checkMark", checkValue: "false", index: 10, study: "")]
    
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
        return learning.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = learning[indexPath.row]
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
        if segue.identifier == "showLearningDetail" {
            
            if let indexPath = self.tableViewOutlet.indexPathForSelectedRow {
                let navController = segue.destination as! UINavigationController
                let VC = navController.topViewController as! learningDetailViewController
                VC.selectedName = learning[indexPath.row]
            }
        }
    }
}
