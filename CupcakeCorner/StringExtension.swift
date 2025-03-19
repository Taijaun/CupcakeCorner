//
//  StringExtension.swift
//  CupcakeCorner
//
//  Created by Taijaun Pitt on 19/03/2025.
//

import Foundation

extension String {
    var isOnlyWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
