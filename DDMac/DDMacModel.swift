//
//  DDMacModel.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import DDCore

// Model type (MVVM)
struct DDMacModel {
    var solutions: [Solution]
    var tags: [Tag]
    var processes: [BusinessProcess]
    var currentSolutionID: String = ""
    var currentTagID: String = ""
    var currentProcessID: String = ""
    
    mutating func chooseSolution(_ solution: Solution) {
        print("Solution chosen: \(solution)")
        self.currentSolutionID = solution.id
    }
    
    mutating func chooseTag(_ tag: Tag) {
        print("Tag chosen: \(tag)")
        self.currentTagID = tag.id
    }
    
    mutating func chooseProcess(_ process: BusinessProcess) {
        print("Process chosen: \(process)")
        self.currentProcessID = process.id
    }
    
    
//    var tags: [Tag]
//    var languages: [Language]
}
