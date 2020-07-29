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
    @Published var currentSolution: Solution? = nil
    @Published var currentTag: Tag? = nil
    @Published var currentProcess: DDProcess? = nil
    @Published var currentFlow: Flow? = nil
    @Published var currentStep: Step? = nil
    
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
        model.rebuildDisplayData(solution: currentSolution, tag: currentTag, process: currentProcess, flow: currentFlow, step: currentStep)
    }
    
    func chooseSolution(_ solution: Solution) {
        currentSolution = solution
        rebuildData()
    }
    func chooseTag(_ tag: Tag) {
        currentTag = tag
        rebuildData()
    }
    func chooseProcess(_ process: DDProcess) {
        currentProcess = process
        rebuildData()
    }
    func chooseFlow(_ flow: Flow) {
        currentFlow = flow
        rebuildData()
    }
    func chooseStep(_ step: Step) {
        currentStep = step
        rebuildData()
    }
    
    func edit(_ someID: String) {
        editing = someID
    }
    
    func save(_ someID: String) {
        editing = ""
    }
}
