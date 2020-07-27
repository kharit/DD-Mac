//
//  DDMacApp.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

// ViewModel class (MVVM)
class DDMacApp: ObservableObject {
    @Published private(set) var model: DDMacModel = DDMacApp.createDDMacModel()
    private(set) var currentLanguage = Language.EN
    var lang: String {
        currentLanguage.rawValue
    }
    var currentSolutionID: String {
        model.currentSolutionID
    }
    var currentSolution = Solution(id: "ERP01", name: ["EN":"ERP 01"], businessProcesses: [String]())
    var currentTagID: String {
        model.currentTagID
    }
    var currentProcessID: String {
        model.currentProcessID
    }
    
    static func createDDMacModel() -> DDMacModel{
        return DDMacModel(
            solutions: [
                Solution(id: "ERP01", name: ["EN":"ERP 01"], businessProcesses: [String]()),
                Solution(id: "WMS01", name: ["EN":"EWM 01"], businessProcesses: [String]()),
            ],
            tags: [
                Tag(id: "1", name: ["EN":"Global"]),
                Tag(id: "2", name: ["EN":"Kharit EU"]),
                Tag(id: "3", name: ["EN":"Kharit US"]),
            ],
            processes: [
                BusinessProcess(id: "21", name: ["EN": "Goods receipt from truck"], flows: [String](), relevantTags: [String](), description: ["EN": "Goods receipt from truck description"]),
                BusinessProcess(id: "22", name: ["EN": "Goods issue to truck"], flows: [String](), relevantTags: [String](), description: ["EN": "Goods issue to truck description"]),
            ]
        )
    }
    
    // MARK: - Access to the Model
    
    var solutions: [Solution] {
        model.solutions
    }
    var tags: [Tag] {
        model.tags
    }
    var processes: [BusinessProcess] {
        model.processes
    }
    
    // MARK: - Intent(s)
    
    func chooseSolution(_ solution: Solution) {
        model.chooseSolution(solution)
    }
    func chooseTag(_ tag: Tag) {
        model.chooseTag(tag)
    }
    func chooseProcess(_ process: BusinessProcess) {
        model.chooseProcess(process)
    }
}
