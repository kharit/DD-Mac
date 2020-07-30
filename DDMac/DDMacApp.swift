//
//  DDMacApp.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore
import Combine

// ViewModel class (MVVM)
final class DDMacApp: ObservableObject {
    @Published var model: DataManager = DDMacApp.createDataManager()
    @Published private(set) var currentLanguage = Language.EN
    @Published var currentSolutionID = ""
    @Published var currentTagID = ""
    @Published var currentProcessID = ""
    @Published var currentFlowID = ""
    @Published var currentStepID = ""
    
    @Published var editing: String = ""
    
    var lang: String {
        currentLanguage.rawValue
    }
    
    static func createDataManager() -> DataManager {
        return DataManager.initWithTestData()
    }
    
    // MARK: - Access to the Model
    
    var data: DataCollection {
        model.displayData
    }
    
    // MARK: - Intent(s)
    
    func rebuildData() {
        model.rebuildDisplayData(solution: currentSolutionID, tag: currentTagID, process: currentProcessID, flow: currentFlowID, step: currentStepID)
        // TODO: if selected item is not on screen, drop all childs from the screen as well
    }
    
    func chooseSolution(_ solution: Solution) {
        currentSolutionID = solution.id
        rebuildData()
    }
    func chooseTag(_ tag: Tag) {
        currentTagID = tag.id
        rebuildData()
    }
    func chooseProcess(_ process: DDProcess) {
        currentProcessID = process.id
        rebuildData()
    }
    func chooseFlow(_ flow: Flow) {
        currentFlowID = flow.id
        rebuildData()
    }
    func chooseStep(_ step: Step) {
        currentStepID = step.id
        rebuildData()
    }
    
    func edit(_ someID: String) {
        editing = someID
    }
    
    func saveStep(_ step: Step) {
        editing = ""
        
        // TODO: Check if the step is used in other flows
        
        model.saveStep(step)
    }
    
    // adds step to a given position or to an end if step is nil
    func addStep(_ step: Step, before beforeStep: Step?) {
        model.addStep(step, to: self.currentFlowID, before: beforeStep)
    }
    
    // adds step to a given position or to an end if step is nil
    func addSystem() {
        
    }
}
