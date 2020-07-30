//
//  TestData.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 30.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import Foundation
import DDCore

extension DDMacApp {
    static func initPreview() -> DDMacApp {
        let app = DDMacApp()
        
        let currentValues = app.model.getCurrentStuff()
        
        for currentElement in currentValues {
            if let solution: Solution = currentElement as? Solution {
                app.currentSolutionID = solution.id
            }
            if let tag: Tag = currentElement as? Tag {
                app.currentTagID = tag.id
            }
            if let process: DDProcess = currentElement as? DDProcess {
                app.currentProcessID = process.id
            }
            if let flow: Flow = currentElement as? Flow {
                app.currentFlowID = flow.id
            }
            if let step: Step = currentElement as? Step {
                app.currentStepID = step.id
            }
        }
        
        app.rebuildData()
        
        return app
    }
}
