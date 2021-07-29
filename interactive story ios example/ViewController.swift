//
//  ViewController.swift
//  interactive story ios example
//
//  Created by Yudha S on 2021/7/28.
//  Copyright © 2021 Macx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextFIeld: UITextField!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            
            do {
                if let name = nameTextFIeld.text {
                    if name == "" {
                        throw AdventureError.nameNotProvided
                    } else {
                        guard let pageController = segue.destination as? PageController else {return}
                        pageController.page = Adventure.story(withName: name)
                    }
                }
            } catch AdventureError.nameNotProvided {
                let alertController = UIAlertController(title: "Name Not Provided", message: "Provide a name to start a story", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                
                present(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error.localizedDescription)")
            }
        
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardFrame.cgRectValue
            textFieldBottomConstraint.constant = frame.size.height + 10
            
            UIView.animate(withDuration: 0.8){
                self.view.layoutIfNeeded()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

