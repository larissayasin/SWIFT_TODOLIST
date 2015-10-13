//
//  UserSet.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 10/12/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import Foundation
class UserSet {
    static let intialLevel = 0
    let level = "nivel"
    static let intialProgress = 0
    let progress = "progresso"

    func changeUserLevel(nivel : Int){
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setValue(nivel, forKey: level)
    }
    
    func getUserLevel()->Int{
        let prefs = NSUserDefaults.standardUserDefaults()
        let nivel = prefs.integerForKey(level)
        return nivel
    }
    
    func changeUserProgress(progresso : Int){
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setValue(progresso, forKey: progress)
    }
    
    func getUserProgress()->Int{
        let prefs = NSUserDefaults.standardUserDefaults()
        let progresso = prefs.integerForKey(progress)
        return progresso
    }
    
    
}