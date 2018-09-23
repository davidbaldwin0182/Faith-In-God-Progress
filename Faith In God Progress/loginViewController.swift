//
//  loginViewController.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/7/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class loginViewController: UIViewController {
    
    var item: [UserData] = []
    var user: User?
    let toTVC1 = "toTVC1"
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.textContentType = .username
        password.textContentType = .password
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.toTVC1, sender: nil)
                self.userName.text = nil
                self.password.text = nil
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // dismiss keyboard
    @IBAction func dismissUser(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    // dismiss keyboard
    @IBAction func dismissPassword(_ sender: Any) {
        self.resignFirstResponder()
    }
    @IBAction func nonRegisterSignIn(_ sender: Any) {

        Auth.auth().signInAnonymously() { (authResult, error) in

        }
    }
    
    // Sign in user
    @IBAction func signIn(_ sender: Any) {
        
        guard
            let email = userName.text,
            let password = password.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Register a new user
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.userName.text!,
                                       password: self.password.text!)
                }
                else
                {
                    let alert = UIAlertController(title: "Register Error",
                                                  message: "Error trying to Register",
                                                  preferredStyle: .alert)
                    
                    let saveAction = UIAlertAction(title: "OK", style: .default) { _ in
                    }
                    alert.addAction(saveAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Retrive lost password
    @IBAction func lostPassword(_ sender: Any) {
    }
    
}

extension loginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userName {
            password.becomeFirstResponder()
        }
        if textField == password {
            textField.resignFirstResponder()
        }
        return true
    }
}

