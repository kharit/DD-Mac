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
    var dataManager: DataManager
    var data: DataCollection {
        dataManager.displayData
    }
    var currentSolution: Solution? = nil
    var currentTag: Tag? = nil
    var currentProcess: DDProcess? = nil
    var currentFlow: Flow? = nil
    var currentStep: Step? = nil
    
    mutating func chooseSolution(_ solution: Solution) {
        print("Solution chosen: \(solution)")
        self.currentSolution = solution
        dataManager.chooseSolution(solution)
        print(data.processes)
    }
    
    mutating func chooseTag(_ tag: Tag) {
        print("Tag chosen: \(tag)")
        self.currentTag = tag
        
        //TODO: rebuild data according to selection
    }
    
    mutating func chooseProcess(_ process: DDProcess) {
        print("Process chosen: \(process)")
        self.currentProcess = process
        
        //TODO: rebuild data according to selection
    }
    
    mutating func chooseFlow(_ flow: Flow) {
        print("Flow is chosen: \(flow)")
        self.currentFlow = flow
        
        //TODO: rebuild data according to selection
    }
    
    mutating func chooseStep(_ step: Step) {
        print("Step is chosen: \(step)")
        self.currentStep = step
        
        //TODO: rebuild data according to selection
    }
    
//    var languages: [Language] (will be done way later). For each language there will be a separate git repository. Which has to be manually create first. Then it can be populated from another language (English?)
}
