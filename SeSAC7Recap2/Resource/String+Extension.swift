//
//  String+Extension.swift
//  SeSAC7Recap2
//
//  Created by andev on 9/4/25.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func myLocalized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
