//
//  Model.swift
//  MashUp
//
//  Created by Hyun on 2021/06/18.
//

import Foundation

struct Contact: Codable {
    var id: Int
    var title: String
    var content: String
    var headcount: Int
    var max: Int
    var createdate: String
    var category: Int
}

