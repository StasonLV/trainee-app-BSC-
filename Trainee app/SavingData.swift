//
//  SavingData.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import Foundation

final class TextFieldData {
    
    private enum DataKeys: String {
        
        case titleData
        
        case noteData
    }
    
    static var titleData: String! {
        get {
            return UserDefaults.standard.string(forKey: DataKeys.titleData.rawValue)
        } set {
            
            let defaults = UserDefaults.standard
            let key = DataKeys.titleData.rawValue
            if let data = newValue {
                print("value: \(data) was added to key \(key)")
                defaults.set(data, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    static var noteData: String! {
        get {
            return UserDefaults.standard.string(forKey: DataKeys.noteData.rawValue)
        } set {
            
            let defaults = UserDefaults.standard
            let key = DataKeys.noteData.rawValue
            if let data = newValue {
                print("value: \(data) was added to key \(key)")
                defaults.set(data, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
