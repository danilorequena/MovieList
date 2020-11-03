//
//  String+LocalizableHelper.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 14/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

extension String {
    var localized : String {
        return NSLocalizedString(self, comment: "")
    }
}
