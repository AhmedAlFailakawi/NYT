//
//  ResponseError.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/7/22.
//

import Foundation

struct ResponseError: Codable {
    let fault: Fault
}

struct Fault: Codable {
    let faultstring: String
    let detail: Detail
}

struct Detail: Codable {
    let errorcode: String
}
