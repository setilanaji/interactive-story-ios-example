//
//  ViewController.swift
//  interactive story ios example
//
//  Created by Yudha S on 2021/7/28.
//  Copyright © 2021 Macx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            guard let pageController = segue.destination as? PageController else {
                return
            }
            
            pageController.page = Adventure.story
        }
    }


}

