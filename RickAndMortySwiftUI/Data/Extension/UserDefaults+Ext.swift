//
//  UserDefaults+Ext.swift
//  SampleProject
//
//  Created by Valeh Amirov on 29.05.24.
//

import Foundation

extension UserDefaults {
    
    
    enum Keys: String {
        case check = "b@okM@rk"
    }
    
    var checkData: Data? {
        get {
            return data(forKey: Keys.check.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.check.rawValue)
        }
    }
}
