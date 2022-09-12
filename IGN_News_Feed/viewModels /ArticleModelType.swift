//
//  ArticleModelType.swift
//  IGN_News_Feed
//
//  Created by Angarag Gansukh on 9/12/22.
//

import Foundation

struct Article {
    let id: String
    let thumbnails: [ArticleThumbnail]
    let metadata: ArticleInfo
    let authors: [Author]
}

extension Article: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "contentId"
        case thumbnails
        case metadata
        case authors
    }
}

struct ArticleInfo: Codable {
    let headline: String
    let description: String?
}

struct ArticleThumbnail: Codable {
    let url: String?
    let size: String?
}

struct Author: Codable {
    let name: String
    let url: String
}
