//
//  tabViewController2.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/7/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class tabViewController2: UIViewController {
    
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
    
    var progress: Progress?
    
    let myDoc1 = "myDocB1"
    let myDoc2 = "myDocB2"
    let myDoc3 = "myDocB3"
    let myDoc4 = "myDocB4"
    let myDoc5 = "myDocB5"
    let myDoc6 = "myDocB6"
    
    let myDoc7 = "myDocL1"
    let myDoc8 = "myDocL2"
    let myDoc9 = "myDocL3"
    let myDoc10 = "myDocL4"
    let myDoc11 = "myDocL5"
    let myDoc12 = "myDocL6"
    let myDoc13 = "myDocL7"
    let myDoc14 = "myDocL8"
    let myDoc15 = "myDocL9"
    let myDoc16 = "myDocL10"
    
    let myDoc17 = "myDocS1"
    let myDoc18 = "myDocS2"
    let myDoc19 = "myDocS3"
    let myDoc20 = "myDocS4"
    let myDoc21 = "myDocS5"
    let myDoc22 = "myDocS6"
    let myDoc23 = "myDocS7"
    let myDoc24 = "myDocS8"
    let myDoc25 = "myDocS9"
    let myDoc26 = "myDocS10"
    
    let myDoc27 = "myDocT1"
    let myDoc28 = "myDocT2"
    let myDoc29 = "myDocT3"
    let myDoc30 = "myDocT4"
    let myDoc31 = "myDocT5"
    let myDoc32 = "myDocT6"
    let myDoc33 = "myDocT7"
    let myDoc34 = "myDocT8"
    let myDoc35 = "myDocT9"
    let myDoc36 = "myDocT10"
    
    let myDoc37 = "myDocP1"
    let myDoc38 = "myDocP2"
    let myDoc39 = "myDocP3"
    let myDoc40 = "myDocP4"
    let myDoc41 = "myDocP5"
    
    let myDoc42 = "myDocA1"
    let myDoc43 = "myDocA2"
    let myDoc44 = "myDocA3"
    let myDoc45 = "myDocA4"
    let myDoc46 = "myDocA5"
    let myDoc47 = "myDocA6"
    let myDoc48 = "myDocA7"
    let myDoc49 = "myDocA8"
    let myDoc50 = "myDocA9"
    let myDoc51 = "myDocA10"
    let myDoc52 = "myDocA11"
    let myDoc53 = "myDocA12"
    let myDoc54 = "myDocA13"
    
    let myDoc55 = "myDocT"
    
    let myDoc56 = "myDocI"
    
    var buttonBasic1 = "false"
    var buttonBasic2 = "false"
    var buttonBasic3 = "false"
    var buttonBasic4 = "false"
    var buttonBasic5 = "false"
    var buttonBasic6 = "false"
    
    var buttonLearning1 = "false"
    var buttonLearning2 = "false"
    var buttonLearning3 = "false"
    var buttonLearning4 = "false"
    var buttonLearning5 = "false"
    var buttonLearning6 = "false"
    var buttonLearning7 = "false"
    var buttonLearning8 = "false"
    var buttonLearning9 = "false"
    var buttonLearning10 = "false"
    
    var buttonServing1 = "false"
    var buttonServing2 = "false"
    var buttonServing3 = "false"
    var buttonServing4 = "false"
    var buttonServing5 = "false"
    var buttonServing6 = "false"
    var buttonServing7 = "false"
    var buttonServing8 = "false"
    var buttonServing9 = "false"
    var buttonServing10 = "false"
    
    
    var buttonTalents1 = "false"
    var buttonTalents2 = "false"
    var buttonTalents3 = "false"
    var buttonTalents4 = "false"
    var buttonTalents5 = "false"
    var buttonTalents6 = "false"
    var buttonTalents7 = "false"
    var buttonTalents8 = "false"
    var buttonTalents9 = "false"
    var buttonTalents10 = "false"
    
    var buttonPreWomen1 = "false"
    var buttonPreWomen2 = "false"
    var buttonPreWomen3 = "false"
    var buttonPreWomen4 = "false"
    var buttonPreWomen5 = "false"
    
    var buttonArticle1 = "false"
    var buttonArticle2 = "false"
    var buttonArticle3 = "false"
    var buttonArticle4 = "false"
    var buttonArticle5 = "false"
    var buttonArticle6 = "false"
    var buttonArticle7 = "false"
    var buttonArticle8 = "false"
    var buttonArticle9 = "false"
    var buttonArticle10 = "false"
    var buttonArticle11 = "false"
    var buttonArticle12 = "false"
    var buttonArticle13 = "false"
    
    var buttonTestimony = "false"
    
    var buttonIterview = "false"
    
    @IBOutlet weak var preparingFor: UILabel!
    @IBOutlet weak var imageBg: UIImageView!
    
    @IBOutlet weak var basicBtn1: UIButton!
    @IBOutlet weak var basicBtn2: UIButton!
    @IBOutlet weak var basicBtn3: UIButton!
    @IBOutlet weak var basicBtn4: UIButton!
    @IBOutlet weak var basicBtn5: UIButton!
    @IBOutlet weak var basicBtn6: UIButton!
    
    @IBOutlet weak var learnBtn1: UIButton!
    @IBOutlet weak var learnBtn2: UIButton!
    @IBOutlet weak var learnBtn3: UIButton!
    @IBOutlet weak var learnBtn4: UIButton!
    @IBOutlet weak var learnBtn5: UIButton!
    @IBOutlet weak var learnBtn6: UIButton!
    @IBOutlet weak var learnBtn7: UIButton!
    @IBOutlet weak var learnBtn8: UIButton!
    @IBOutlet weak var learnBtn9: UIButton!
    @IBOutlet weak var learnBtn10: UIButton!
    
    @IBOutlet weak var servingBtn1: UIButton!
    @IBOutlet weak var servingBtn2: UIButton!
    @IBOutlet weak var servingBtn3: UIButton!
    @IBOutlet weak var servingBtn4: UIButton!
    @IBOutlet weak var servingBtn5: UIButton!
    @IBOutlet weak var servingBtn6: UIButton!
    @IBOutlet weak var servingBtn7: UIButton!
    @IBOutlet weak var servingBtn8: UIButton!
    @IBOutlet weak var servingBtn9: UIButton!
    @IBOutlet weak var servingBtn10: UIButton!
    
    @IBOutlet weak var talentBtn1: UIButton!
    @IBOutlet weak var talentBtn2: UIButton!
    @IBOutlet weak var talentBtn3: UIButton!
    @IBOutlet weak var talentBtn4: UIButton!
    @IBOutlet weak var talentBtn5: UIButton!
    @IBOutlet weak var talentBtn6: UIButton!
    @IBOutlet weak var talentBtn7: UIButton!
    @IBOutlet weak var talentBtn8: UIButton!
    @IBOutlet weak var talentBtn9: UIButton!
    @IBOutlet weak var talentBtn10: UIButton!
    
    @IBOutlet weak var preWomenBtn1: UIButton!
    @IBOutlet weak var preWomenBtn2: UIButton!
    @IBOutlet weak var preWomenBtn3: UIButton!
    @IBOutlet weak var preWomenBtn4: UIButton!
    
    @IBOutlet weak var preWomenBtn5: UIButton!
    
    @IBOutlet weak var articleBtn1: UIButton!
    @IBOutlet weak var articleBtn2: UIButton!
    @IBOutlet weak var articleBtn3: UIButton!
    @IBOutlet weak var articleBtn4: UIButton!
    @IBOutlet weak var articleBtn5: UIButton!
    @IBOutlet weak var articleBtn6: UIButton!
    @IBOutlet weak var articleBtn7: UIButton!
    @IBOutlet weak var articleBtn8: UIButton!
    @IBOutlet weak var articleBtn9: UIButton!
    @IBOutlet weak var articleBtn10: UIButton!
    @IBOutlet weak var articleBtn11: UIButton!
    @IBOutlet weak var articleBtn12: UIButton!
    @IBOutlet weak var articleBtn13: UIButton!
    
    @IBOutlet weak var testimony: UIButton!
    
    @IBOutlet weak var interview: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        buttonValBoys = show(document: myDocBoys, buttonValue: buttonValBoys)
        buttonValGirls = show(document: myDocGirls, buttonValue: buttonValGirls)
        if buttonValBoys == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightblue")
            preparingFor.text = "PREPARING FOR THE PRIESTHOOD"
        }
        if buttonValGirls == "true" {
            imageBg.image = UIImage(named:"faith_in_god_blank_lightpink")
            preparingFor.text = "PREPARING FOR YOUNG WOMEN"
            
        }
        
        buttonBasic1 = show(document: myDoc1, buttonValue: buttonBasic1)
        buttonBasic2 = show(document: myDoc2, buttonValue: buttonBasic2)
        buttonBasic3 = show(document: myDoc3, buttonValue: buttonBasic3)
        buttonBasic4 = show(document: myDoc4, buttonValue: buttonBasic4)
        buttonBasic5 = show(document: myDoc5, buttonValue: buttonBasic5)
        buttonBasic6 = show(document: myDoc6, buttonValue: buttonBasic6)
        
        buttonLearning1 = show(document: myDoc7, buttonValue: buttonLearning1)
        buttonLearning2 = show(document: myDoc8, buttonValue: buttonLearning2)
        buttonLearning3 = show(document: myDoc9, buttonValue: buttonLearning3)
        buttonLearning4 = show(document: myDoc10, buttonValue: buttonLearning4)
        buttonLearning5 = show(document: myDoc11, buttonValue: buttonLearning5)
        buttonLearning6 = show(document: myDoc12, buttonValue: buttonLearning6)
        buttonLearning7 = show(document: myDoc13, buttonValue: buttonLearning7)
        buttonLearning8 = show(document: myDoc14, buttonValue: buttonLearning8)
        buttonLearning9 = show(document: myDoc15, buttonValue: buttonLearning9)
        buttonLearning10 = show(document: myDoc16, buttonValue: buttonLearning10)
        
        buttonServing1 = show(document: myDoc17, buttonValue: buttonServing1)
        buttonServing2 = show(document: myDoc18, buttonValue: buttonServing2)
        buttonServing3 = show(document: myDoc19, buttonValue: buttonServing3)
        buttonServing4 = show(document: myDoc20, buttonValue: buttonServing4)
        buttonServing5 = show(document: myDoc21, buttonValue: buttonServing5)
        buttonServing6 = show(document: myDoc22, buttonValue: buttonServing6)
        buttonServing7 = show(document: myDoc23, buttonValue: buttonServing7)
        buttonServing8 = show(document: myDoc24, buttonValue: buttonServing8)
        buttonServing9 = show(document: myDoc25, buttonValue: buttonServing9)
        buttonServing10 = show(document: myDoc26, buttonValue: buttonServing10)
        
        buttonTalents1 = show(document: myDoc27, buttonValue: buttonTalents1)
        buttonTalents2 = show(document: myDoc28, buttonValue: buttonTalents2)
        buttonTalents3 = show(document: myDoc29, buttonValue: buttonTalents3)
        buttonTalents4 = show(document: myDoc30, buttonValue: buttonTalents4)
        buttonTalents5 = show(document: myDoc31, buttonValue: buttonTalents5)
        buttonTalents6 = show(document: myDoc32, buttonValue: buttonTalents6)
        buttonTalents7 = show(document: myDoc33, buttonValue: buttonTalents7)
        buttonTalents8 = show(document: myDoc34, buttonValue: buttonTalents8)
        buttonTalents9 = show(document: myDoc35, buttonValue: buttonTalents9)
        buttonTalents10 = show(document: myDoc36, buttonValue: buttonTalents10)
        
        buttonPreWomen1 = show(document: myDoc37, buttonValue: buttonPreWomen1)
        buttonPreWomen2 = show(document: myDoc38, buttonValue: buttonPreWomen2)
        buttonPreWomen3 = show(document: myDoc39, buttonValue: buttonPreWomen3)
        buttonPreWomen4 = show(document: myDoc40, buttonValue: buttonPreWomen4)
        buttonPreWomen5 = show(document: myDoc41, buttonValue: buttonPreWomen5)
        
        buttonArticle1 = show(document: myDoc42, buttonValue: buttonArticle1)
        buttonArticle2 = show(document: myDoc43, buttonValue: buttonArticle2)
        buttonArticle3 = show(document: myDoc44, buttonValue: buttonArticle3)
        buttonArticle4 = show(document: myDoc45, buttonValue: buttonArticle4)
        buttonArticle5 = show(document: myDoc46, buttonValue: buttonArticle5)
        buttonArticle6 = show(document: myDoc47, buttonValue: buttonArticle6)
        buttonArticle7 = show(document: myDoc48, buttonValue: buttonArticle7)
        buttonArticle8 = show(document: myDoc49, buttonValue: buttonArticle8)
        buttonArticle9 = show(document: myDoc50, buttonValue: buttonArticle9)
        buttonArticle10 = show(document: myDoc51, buttonValue: buttonArticle10)
        buttonArticle11 = show(document: myDoc52, buttonValue: buttonArticle11)
        buttonArticle12 = show(document: myDoc53, buttonValue: buttonArticle12)
        buttonArticle13 = show(document: myDoc54, buttonValue: buttonArticle13)
        
        buttonTestimony = show(document: myDoc55, buttonValue: buttonTestimony)
        
        buttonIterview = show(document: myDoc56, buttonValue: buttonIterview)
        
        if buttonBasic1 == "true" { basicBtn1.backgroundColor = UIColor.cyan }
        else
        { basicBtn1.backgroundColor = UIColor.clear }
        if buttonBasic2 == "true" { basicBtn2.backgroundColor = UIColor.cyan }
        else
        { basicBtn2.backgroundColor = UIColor.clear }
        if buttonBasic3 == "true" { basicBtn3.backgroundColor = UIColor.cyan }
        else
        { basicBtn3.backgroundColor = UIColor.clear }
        if buttonBasic4 == "true" { basicBtn4.backgroundColor = UIColor.cyan }
        else
        { basicBtn4.backgroundColor = UIColor.clear }
        if buttonBasic5 == "true" { basicBtn5.backgroundColor = UIColor.cyan }
        else
        { basicBtn5.backgroundColor = UIColor.clear }
        if buttonBasic6 == "true" { basicBtn6.backgroundColor = UIColor.cyan }
        else
        { basicBtn6.backgroundColor = UIColor.clear }
        
        if buttonLearning1 == "true" { learnBtn1.backgroundColor = UIColor.cyan }
        else
        { learnBtn1.backgroundColor = UIColor.clear }
        if buttonLearning2 == "true" { learnBtn2.backgroundColor = UIColor.cyan }
        else
        { learnBtn2.backgroundColor = UIColor.clear }
        if buttonLearning3 == "true" { learnBtn3.backgroundColor = UIColor.cyan }
        else
        { learnBtn3.backgroundColor = UIColor.clear }
        if buttonLearning4 == "true" { learnBtn4.backgroundColor = UIColor.cyan }
        else
        { learnBtn4.backgroundColor = UIColor.clear }
        if buttonLearning5 == "true" { learnBtn5.backgroundColor = UIColor.cyan }
        else
        { learnBtn5.backgroundColor = UIColor.clear }
        if buttonLearning6 == "true" { learnBtn6.backgroundColor = UIColor.cyan }
        else
        { learnBtn6.backgroundColor = UIColor.clear }
        if buttonLearning7 == "true" { learnBtn7.backgroundColor = UIColor.cyan }
        else
        { learnBtn7.backgroundColor = UIColor.clear }
        if buttonLearning8 == "true" { learnBtn8.backgroundColor = UIColor.cyan }
        else
        { learnBtn8.backgroundColor = UIColor.clear }
        if buttonLearning9 == "true" { learnBtn9.backgroundColor = UIColor.cyan }
        else
        { learnBtn9.backgroundColor = UIColor.clear }
        if buttonLearning10 == "true" { learnBtn10.backgroundColor = UIColor.cyan }
        else
        { learnBtn10.backgroundColor = UIColor.clear }
        
        if buttonServing1 == "true" { servingBtn1.backgroundColor = UIColor.cyan }
        else
        { servingBtn1.backgroundColor = UIColor.clear }
        if buttonServing2 == "true" { servingBtn2.backgroundColor = UIColor.cyan }
        else
        { servingBtn2.backgroundColor = UIColor.clear }
        if buttonServing3 == "true" { servingBtn3.backgroundColor = UIColor.cyan }
        else
        { servingBtn3.backgroundColor = UIColor.clear }
        if buttonServing4 == "true" { servingBtn4.backgroundColor = UIColor.cyan }
        else
        { servingBtn4.backgroundColor = UIColor.clear }
        if buttonServing5 == "true" { servingBtn5.backgroundColor = UIColor.cyan }
        else
        { servingBtn5.backgroundColor = UIColor.clear }
        if buttonServing6 == "true" { servingBtn6.backgroundColor = UIColor.cyan }
        else
        { servingBtn6.backgroundColor = UIColor.clear }
        if buttonServing7 == "true" { servingBtn7.backgroundColor = UIColor.cyan }
        else
        { servingBtn7.backgroundColor = UIColor.clear }
        if buttonServing8 == "true" { servingBtn8.backgroundColor = UIColor.cyan }
        else
        { servingBtn8.backgroundColor = UIColor.clear }
        if buttonServing9 == "true" { servingBtn9.backgroundColor = UIColor.cyan }
        else
        { servingBtn9.backgroundColor = UIColor.clear }
        if buttonServing10 == "true" { servingBtn10.backgroundColor = UIColor.cyan }
        else
        { servingBtn10.backgroundColor = UIColor.clear }
        
        if buttonTalents1 == "true" { talentBtn1.backgroundColor = UIColor.cyan }
        else
        { talentBtn1.backgroundColor = UIColor.clear }
        if buttonTalents2 == "true" { talentBtn2.backgroundColor = UIColor.cyan }
        else
        { talentBtn2.backgroundColor = UIColor.clear }
        if buttonTalents3 == "true" { talentBtn3.backgroundColor = UIColor.cyan }
        else
        { talentBtn3.backgroundColor = UIColor.clear }
        if buttonTalents4 == "true" { talentBtn4.backgroundColor = UIColor.cyan }
        else
        { talentBtn4.backgroundColor = UIColor.clear }
        if buttonTalents5 == "true" { talentBtn5.backgroundColor = UIColor.cyan }
        else
        { talentBtn5.backgroundColor = UIColor.clear }
        if buttonTalents6 == "true" { talentBtn6.backgroundColor = UIColor.cyan}
        else
        { talentBtn6.backgroundColor = UIColor.clear }
        if buttonTalents7 == "true" { talentBtn7.backgroundColor = UIColor.cyan }
        else
        { talentBtn7.backgroundColor = UIColor.clear }
        if buttonTalents8 == "true" { talentBtn8.backgroundColor = UIColor.cyan }
        else
        { talentBtn8.backgroundColor = UIColor.clear }
        if buttonTalents9 == "true" { talentBtn9.backgroundColor = UIColor.cyan }
        else
        { talentBtn9.backgroundColor = UIColor.clear }
        if buttonTalents10 == "true" { talentBtn10.backgroundColor = UIColor.cyan }
        else
        { talentBtn10.backgroundColor = UIColor.clear }
        
        if buttonPreWomen1 == "true" { preWomenBtn1.backgroundColor = UIColor.cyan }
        else
        { preWomenBtn1.backgroundColor = UIColor.clear }
        if buttonPreWomen2 == "true" { preWomenBtn2.backgroundColor = UIColor.cyan }
        else
        { preWomenBtn2.backgroundColor = UIColor.clear }
        if buttonPreWomen3 == "true" { preWomenBtn3.backgroundColor = UIColor.cyan }
        else
        { preWomenBtn3.backgroundColor = UIColor.clear }
        if buttonPreWomen4 == "true" { preWomenBtn4.backgroundColor = UIColor.cyan }
        else
        { preWomenBtn4.backgroundColor = UIColor.clear }
        if buttonPreWomen5 == "true" { preWomenBtn5.backgroundColor = UIColor.cyan }
        else
        { preWomenBtn5.backgroundColor = UIColor.clear }
        
        
        if buttonArticle1 == "true" { articleBtn1.backgroundColor = UIColor.cyan }
        else
        { articleBtn1.backgroundColor = UIColor.clear }
        if buttonArticle2 == "true" { articleBtn2.backgroundColor = UIColor.cyan }
        else
        { articleBtn2.backgroundColor = UIColor.clear }
        if buttonArticle3 == "true" { articleBtn3.backgroundColor = UIColor.cyan }
        else
        { articleBtn3.backgroundColor = UIColor.clear }
        if buttonArticle4 == "true" { articleBtn4.backgroundColor = UIColor.cyan }
        else
        { articleBtn4.backgroundColor = UIColor.clear }
        if buttonArticle5 == "true" { articleBtn5.backgroundColor = UIColor.cyan }
        else
        { articleBtn5.backgroundColor = UIColor.clear }
        if buttonArticle6 == "true" { articleBtn6.backgroundColor = UIColor.cyan}
        else
        { articleBtn6.backgroundColor = UIColor.clear }
        if buttonArticle7 == "true" { articleBtn7.backgroundColor = UIColor.cyan }
        else
        { articleBtn7.backgroundColor = UIColor.clear }
        if buttonArticle8 == "true" { articleBtn8.backgroundColor = UIColor.cyan }
        else
        { articleBtn8.backgroundColor = UIColor.clear }
        if buttonArticle9 == "true" { articleBtn9.backgroundColor = UIColor.cyan }
        else
        { articleBtn9.backgroundColor = UIColor.clear }
        if buttonArticle10 == "true" { articleBtn10.backgroundColor = UIColor.cyan }
        else
        { articleBtn10.backgroundColor = UIColor.clear }
        if buttonArticle11 == "true" { articleBtn11.backgroundColor = UIColor.cyan }
        else
        { articleBtn11.backgroundColor = UIColor.clear }
        if buttonArticle12 == "true" { articleBtn12.backgroundColor = UIColor.cyan }
        else
        { articleBtn12.backgroundColor = UIColor.clear }
        if buttonArticle13 == "true" { articleBtn13.backgroundColor = UIColor.cyan }
        else
        { articleBtn13.backgroundColor = UIColor.clear }
        
        if buttonTestimony == "true" { testimony.backgroundColor = UIColor.cyan }
        else
        { testimony.backgroundColor = UIColor.clear }
        
        if buttonIterview == "true" { interview.backgroundColor = UIColor.cyan }
        else
        { interview.backgroundColor = UIColor.clear }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func basicRecBtn1(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonBasic1 = saveFile(document: myDoc1, buttonValue: buttonBasic1, boxColor: myColorVal, buttonAttribute: basicBtn1)
    }
    @IBAction func basicRecBtn2(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonBasic2 = saveFile(document: myDoc2, buttonValue: buttonBasic2, boxColor: myColorVal, buttonAttribute: basicBtn2)
    }
    @IBAction func basicRecBtn3(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonBasic3 = saveFile(document: myDoc3, buttonValue: buttonBasic3, boxColor: myColorVal, buttonAttribute: basicBtn3)
    }
    @IBAction func basicRecBtn4(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonBasic4 = saveFile(document: myDoc4, buttonValue: buttonBasic4, boxColor: myColorVal, buttonAttribute: basicBtn4)
    }
    @IBAction func basicRecBtn5(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonBasic5 = saveFile(document: myDoc5, buttonValue: buttonBasic5, boxColor: myColorVal, buttonAttribute: basicBtn5)
    }
    @IBAction func basicRecBtn6(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonBasic6 = saveFile(document: myDoc6, buttonValue: buttonBasic6, boxColor: myColorVal, buttonAttribute: basicBtn6)
    }

   
    @IBAction func learnRecBtn1(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning1 = saveFile(document: myDoc7, buttonValue: buttonLearning1, boxColor: myColorVal, buttonAttribute: learnBtn1)
    }
    @IBAction func learnRecBtn2(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning2 = saveFile(document: myDoc8, buttonValue: buttonLearning2, boxColor: myColorVal, buttonAttribute: learnBtn2)
    }
    @IBAction func learnRecBtn3(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning3 = saveFile(document: myDoc9, buttonValue: buttonLearning3, boxColor: myColorVal, buttonAttribute: learnBtn3)
    }
    @IBAction func learnRecBtn4(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning4 = saveFile(document: myDoc10, buttonValue: buttonLearning4, boxColor: myColorVal, buttonAttribute: learnBtn4)
    }
    @IBAction func learnRecBtn5(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning5 = saveFile(document: myDoc11, buttonValue: buttonLearning5, boxColor: myColorVal, buttonAttribute: learnBtn5)
    }
    @IBAction func learnRecBtn6(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning6 = saveFile(document: myDoc12, buttonValue: buttonLearning6, boxColor: myColorVal, buttonAttribute: learnBtn6)
    }
    @IBAction func learnRecBtn7(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning7 = saveFile(document: myDoc13, buttonValue: buttonLearning7, boxColor: myColorVal, buttonAttribute: learnBtn7)
    }
    @IBAction func learnRecBtn8(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning8 = saveFile(document: myDoc14, buttonValue: buttonLearning8, boxColor: myColorVal, buttonAttribute: learnBtn8)
    }
    @IBAction func learnRecBtn9(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning9 = saveFile(document: myDoc15, buttonValue: buttonLearning9, boxColor: myColorVal, buttonAttribute: learnBtn9)
    }
    @IBAction func learnRecBtn10(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonLearning10 = saveFile(document: myDoc16, buttonValue: buttonLearning10, boxColor: myColorVal, buttonAttribute: learnBtn10)
    }
    
    @IBAction func serveRecBtn1(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing1 = saveFile(document: myDoc17, buttonValue: buttonServing1, boxColor: myColorVal, buttonAttribute: servingBtn1)
    }
    @IBAction func serveRecBtn2(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing2 = saveFile(document: myDoc18, buttonValue: buttonServing2, boxColor: myColorVal, buttonAttribute: servingBtn2)
    }
    @IBAction func serveRecBtn3(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing3 = saveFile(document: myDoc19, buttonValue: buttonServing3, boxColor: myColorVal, buttonAttribute: servingBtn3)
    }
    @IBAction func serveRecBtn4(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing4 = saveFile(document: myDoc20, buttonValue: buttonServing4, boxColor: myColorVal, buttonAttribute: servingBtn4)
    }
    @IBAction func serveRecBtn5(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing5 = saveFile(document: myDoc21, buttonValue: buttonServing5, boxColor: myColorVal, buttonAttribute: servingBtn5)
    }
    @IBAction func serveRecBtn6(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing6 = saveFile(document: myDoc22, buttonValue: buttonServing6, boxColor: myColorVal, buttonAttribute: servingBtn6)
    }
    @IBAction func serveRecBtn7(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing7 = saveFile(document: myDoc23, buttonValue: buttonServing7, boxColor: myColorVal, buttonAttribute: servingBtn7)
    }
    @IBAction func serveRecBtn8(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing8 = saveFile(document: myDoc24, buttonValue: buttonServing8, boxColor: myColorVal, buttonAttribute: servingBtn8)
    }
    @IBAction func serveRecBtn9(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing9 = saveFile(document: myDoc25, buttonValue: buttonServing9, boxColor: myColorVal, buttonAttribute: servingBtn9)
    }
    @IBAction func serveRecBtn10(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonServing10 = saveFile(document: myDoc26, buttonValue: buttonServing10, boxColor: myColorVal, buttonAttribute: servingBtn10)
    }
    
    @IBAction func talentRecBtn1(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents1 = saveFile(document: myDoc27, buttonValue: buttonTalents1, boxColor: myColorVal, buttonAttribute: talentBtn1)
    }
    @IBAction func talentRecBtn2(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents2 = saveFile(document: myDoc28, buttonValue: buttonTalents2, boxColor: myColorVal, buttonAttribute: talentBtn2)
    }
    @IBAction func talentRecBtn3(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents3 = saveFile(document: myDoc29, buttonValue: buttonTalents3, boxColor: myColorVal, buttonAttribute: talentBtn3)
    }
    @IBAction func talentRecBtn4(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents4 = saveFile(document: myDoc30, buttonValue: buttonTalents4, boxColor: myColorVal, buttonAttribute: talentBtn4)
    }
    @IBAction func talentRecBtn5(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents5 = saveFile(document: myDoc31, buttonValue: buttonTalents5, boxColor: myColorVal, buttonAttribute: talentBtn5)
    }
    @IBAction func talentRecBtn6(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents6 = saveFile(document: myDoc32, buttonValue: buttonTalents6, boxColor: myColorVal, buttonAttribute: talentBtn6)
    }
    @IBAction func talentRecBtn7(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents7 = saveFile(document: myDoc33, buttonValue: buttonTalents7, boxColor: myColorVal, buttonAttribute: talentBtn7)
    }
    @IBAction func talentRecBtn8(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents8 = saveFile(document: myDoc34, buttonValue: buttonTalents8, boxColor: myColorVal, buttonAttribute: talentBtn8)
    }
    @IBAction func talentRecBtn9(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents9 = saveFile(document: myDoc35, buttonValue: buttonTalents9, boxColor: myColorVal, buttonAttribute: talentBtn9)
    }
    @IBAction func talentRecBtn10(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTalents10 = saveFile(document: myDoc36, buttonValue: buttonTalents10, boxColor: myColorVal, buttonAttribute: talentBtn10)
    }
    
    @IBAction func preWRecBtn1(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonPreWomen1 = saveFile(document: myDoc37, buttonValue: buttonPreWomen1, boxColor: myColorVal, buttonAttribute: preWomenBtn1)
    }
    @IBAction func preWRecBtn2(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonPreWomen2 = saveFile(document: myDoc38, buttonValue: buttonPreWomen2, boxColor: myColorVal, buttonAttribute: preWomenBtn2)
    }
    @IBAction func preWRecBtn3(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonPreWomen3 = saveFile(document: myDoc39, buttonValue: buttonPreWomen3, boxColor: myColorVal, buttonAttribute: preWomenBtn3)
    }
    @IBAction func preWRecBtn4(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonPreWomen4 = saveFile(document: myDoc40, buttonValue: buttonPreWomen4, boxColor: myColorVal, buttonAttribute: preWomenBtn4)
    }
    @IBAction func preWrecBtn5(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonPreWomen5 = saveFile(document: myDoc41, buttonValue: buttonPreWomen5, boxColor: myColorVal, buttonAttribute: preWomenBtn5)
    }
    
    @IBAction func articleRecBtn1(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle1 = saveFile(document: myDoc42, buttonValue: buttonArticle1, boxColor: myColorVal, buttonAttribute: articleBtn1)
    }
    @IBAction func articleRecBtn2(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle2 = saveFile(document: myDoc43, buttonValue: buttonArticle2, boxColor: myColorVal, buttonAttribute: articleBtn2)
    }
    @IBAction func articleRecBtn3(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle3 = saveFile(document: myDoc44, buttonValue: buttonArticle3, boxColor: myColorVal, buttonAttribute: articleBtn3)
    }
    @IBAction func articleRecBtn4(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle4 = saveFile(document: myDoc45, buttonValue: buttonArticle4, boxColor: myColorVal, buttonAttribute: articleBtn4)
    }
    @IBAction func articleRecBtn5(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle5 = saveFile(document: myDoc46, buttonValue: buttonArticle5, boxColor: myColorVal, buttonAttribute: articleBtn5)
    }
    @IBAction func articleRecBtn6(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle6 = saveFile(document: myDoc47, buttonValue: buttonArticle6, boxColor: myColorVal, buttonAttribute: articleBtn6)
    }
    @IBAction func articleRecBtn7(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle7 = saveFile(document: myDoc48, buttonValue: buttonArticle7, boxColor: myColorVal, buttonAttribute: articleBtn7)
    }
    @IBAction func articleRecBtn8(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle8 = saveFile(document: myDoc49, buttonValue: buttonArticle8, boxColor: myColorVal, buttonAttribute: articleBtn8)
    }
    @IBAction func articleRecBtn9(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle9 = saveFile(document: myDoc50, buttonValue: buttonArticle9, boxColor: myColorVal, buttonAttribute: articleBtn9)
    }
    @IBAction func articleRecBtn10(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle10 = saveFile(document: myDoc51, buttonValue: buttonArticle10, boxColor: myColorVal, buttonAttribute: articleBtn10)
    }
    @IBAction func articleRecBtn11(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle11 = saveFile(document: myDoc52, buttonValue: buttonArticle11, boxColor: myColorVal, buttonAttribute: articleBtn11)
    }
    @IBAction func articleRecBtn12(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle12 = saveFile(document: myDoc53, buttonValue: buttonArticle12, boxColor: myColorVal, buttonAttribute: articleBtn12)
    }
    @IBAction func articleRecBtn13(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonArticle13 = saveFile(document: myDoc54, buttonValue: buttonArticle13, boxColor: myColorVal, buttonAttribute: articleBtn13)
       
    }
    
    @IBAction func testimonyRecBtn(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonTestimony = saveFile(document: myDoc55, buttonValue: buttonTestimony, boxColor: myColorVal, buttonAttribute: testimony)
        
    }
    
    @IBAction func interviewRecBtn(_ sender: Any) {
        let myColorVal = UIColor.cyan
        buttonIterview = saveFile(document: myDoc56, buttonValue: buttonIterview, boxColor: myColorVal, buttonAttribute: interview)
    }
    
    // Save status of check box
    func saveFile(document: String, buttonValue: String, boxColor: UIColor, buttonAttribute: UIButton) -> String {
        var myButtonVal = buttonValue
        if let current = currentUserUid {
            newUserUid = current
        }
        let names = newUserUid
        let myDocument = "\(document)\(names).txt"
        var myString = "stringToWrite"
        let myColor = boxColor
        let myButtonAttribute = buttonAttribute
        
        if myButtonVal != "true" {
            let fileManager = FileManager.default
            do {
                let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let url = URL(string: myDocument, relativeTo: documents)
                myButtonVal = "true"
                myButtonAttribute.backgroundColor = myColor
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
                myButtonVal = "false"
                myButtonAttribute.backgroundColor = UIColor.clear
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
    
    // Retrive status of check box
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
