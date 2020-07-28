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
    @Published private(set) var model: DDMacModel = DataManager.initWithTestData()
    private(set) var currentLanguage = Language.EN
    var lang: String {
        currentLanguage.rawValue
    }
    var currentSolution: Solution? {
        model.currentSolution
    }
    var currentTag: Tag? {
        model.currentTag
    }
    var currentProcess: DDProcess? {
        model.currentProcess
    }
    var currentFlow: Flow? {
        model.currentFlow
    }
    var currentStep: Step? {
        model.currentStep
    }
    
    static func createDDMacModel() -> DDMacModel{
        let dataManager = DataManager.initWithTestData()
        return DDMacModel(dataManager: dataManager)
    }
    
    // MARK: - Access to the Model
    
    var data: DataCollection {
        model.data
    }
    
    // MARK: - Intent(s)
    
    func chooseSolution(_ solution: Solution) {
        model.chooseSolution(solution)
    }
    func chooseTag(_ tag: Tag) {
        model.chooseTag(tag)
    }
    func chooseProcess(_ process: DDProcess) {
        model.chooseProcess(process)
    }
    func chooseFlow(_ flow: Flow) {
        model.chooseFlow(flow)
    }
    func chooseStep(_ step: Step) {
        model.chooseStep(step)
    }
}
