//
//  Date+Additions.swift
//  QRCodeScanner
//
//  Created by Dimon on 02/10/2020.
//  Copyright © 2020 dmytrodurda. All rights reserved.
//

import Foundation

extension Date {
    func string(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
