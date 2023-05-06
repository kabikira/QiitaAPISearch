//
//  QiitaModel.swift
//  QiitaAPI
//
//  Created by koala panda on 2023/05/05.
//

import Foundation
struct QiitaModel: Codable {
    let title: String
    let createdAt: String
    let url: URL
    let user: User

    enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case url
        case user
    }
}

struct User: Codable {
    let profileImageURL: URL

    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image_url"
    }
}
// なんでこれダメなん
struct QiitaResponse: Codable {
    var items: [QiitaModel]
}
