//
//  Page.swift
//  interactive story ios example
//
//  Created by Yudha S on 2021/7/28.
//  Copyright © 2021 Macx. All rights reserved.
//

import Foundation


class Page {
    let story: Story
    
    typealias Choice = (title: String, page: Page)
    
    var firstChoice: Choice?
    var secondChoice: Choice?
    
    init(story: Story) {
        self.story = story
    }
}

extension Page {
    
    func addChoiceWith(title: String, story: Story) -> Page {
        let page = Page(story: story)
        return addChoiceWith(title: title, page: page)
    }
    
    func addChoiceWith(title: String, page: Page) -> Page {
        
        switch (firstChoice, secondChoice) {
        case (.some, .some):
            return self
        case (.none, .none), (.none, .some):
            firstChoice = (title, page)
        case (.some, .none):
            secondChoice = (title, page)
        }
        
        return page
    }
}


struct Adventure {
    static var story: Page {
        let returnTrip = Page(story: .returnTrip)
        
       let touchDown = returnTrip.addChoiceWith(title: "Stop and Investigate", story: .touchDown)
        
        let homeward = returnTrip.addChoiceWith(title: "Continue home to Earth", story: .homeward)
        
        let rover = touchDown.addChoiceWith(title: "Explore the rover", story: .rover)
        let crate = touchDown.addChoiceWith(title: "Open the crate", story: .crate)
        
        homeward.addChoiceWith(title: "Head back to Mars", page: touchDown)
        let home = homeward.addChoiceWith(title: "Continue home to Earth", story: .home)
        
        let cave = rover.addChoiceWith(title: "Explore the Coordinates", story: .cave)
        rover.addChoiceWith(title: "Return to Earth", page: home)
        
        cave.addChoiceWith(title: "Continue towards faints light", story: .droid)
        cave.addChoiceWith(title: "Refill the ship and explore the rover", page: rover)
        
        crate.addChoiceWith(title: "Explore the rover", page: rover)
        crate.addChoiceWith(title: "Use the key", story: .monster)
        
        
        return returnTrip
        
    }
}
