//
//  PageController.swift
//  interactive story ios example
//
//  Created by Yudha S on 2021/7/29.
//  Copyright © 2021 Macx. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    var page: Page?
    
    //MARK: - User Interface Properties
    
    let artworkView = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .system)
    let secondChoiceButton = UIButton(type: .system)
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(page: Page){
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let page = page {
            artworkView.image = page.story.artwork
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(artworkView)
        artworkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
             artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
             artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }

}
