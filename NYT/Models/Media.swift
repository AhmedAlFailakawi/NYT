//
//  Media.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/9/22.
//

import Foundation

struct Media: Codable {
    let mediaMetadata: [MediaMetadata]?
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String?
    let format: String?
}
