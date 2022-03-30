//
//  String+.swift
//  coctailsTest
//
//  Created by Anatoliy on 30.03.2022.
//

import Foundation

extension String {
    func isValid() -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString != "" {
            return true
        } else {
            return false
        }
    }
}
