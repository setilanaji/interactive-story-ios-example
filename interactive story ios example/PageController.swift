//
//  PageController.swift
//  interactive story ios example
//
//  Created by Yudha S on 2021/7/29.
//  Copyright © 2021 Macx. All rights reserved.
//

import UIKit

extension NSAttributedString {
    var stringRange: NSRange {
        return NSMakeRange(0, self.length)
    }
}

extension Story {
    var attributedText: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
                   
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
                   
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: attributedString.stringRange)
               
        return attributedString
    }
}

extension Page {
    func story(attributed: Bool) -> NSAttributedString {
        if attributed {
            return story.attributedText
        } else {
            return NSAttributedString(string: story.text)
        }
    }
}

class PageController: UIViewController {
    
    var page: Page?
    let soundEffectPlayer = SoundEffectPlayer()
    
    //MARK: - User Interface Properties
    
    // lazy use when it is needed, in this case will be use after initialization
    lazy var artworkView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = self.page?.story.artwork

        return imageView
    }()
    
    // closure
    lazy var storyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = self.page?.story(attributed: true)
              
        return label
    }()
    
    lazy var firstChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // nil coalising
        let title = self.page?.firstChoice?.title ?? "Play again"
        // ternary conditional operator
        let selector = self.page?.firstChoice != nil ? #selector(PageController.loadFirstChoice) : #selector(PageController.playAgain)
        
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)

        return button
    }()
    
    lazy var secondChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(self.page?.secondChoice?.title, for: .normal)
        button.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)

        return button
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(page: Page){
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(artworkView)
        
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
             artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
             artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        view.addSubview(storyLabel)
      
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: -40.0)
        ])
        
        view.addSubview(firstChoiceButton)
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
        ])
        
        view.addSubview(secondChoiceButton)
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
    }
    
    // @objc used in swift 4
    @objc func loadFirstChoice() {
        if let page = page, let firstChoice = page.firstChoice {
            let nextPage = firstChoice.page
            let pageController = PageController(page: nextPage)
            
            soundEffectPlayer.playSound(for: firstChoice.page.story)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    @objc func loadSecondChoice() {
        if let page = page, let secondChoice = page.secondChoice {
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)
            
            soundEffectPlayer.playSound(for: secondChoice.page.story)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    // @objc used in swift 4
    @objc func playAgain() {
        navigationController?.popToRootViewController(animated: true)
    }
}
