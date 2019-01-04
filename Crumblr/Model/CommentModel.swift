//
//  CommentModel.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 12/26/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation

struct CommentModel: Codable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
    
    
    init(postId: Int?, id: Int?, name: String?, email: String?, body: String?) {
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
    
    enum CommentModelKeys: String, CodingKey {
        case postId = "postId"
        case id = "id"
        case name = "name"
        case email = "email"
        case body = "body"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CommentModelKeys.self)
        let postId = try container.decodeIfPresent(Int.self, forKey: .postId)
        let id = try container.decodeIfPresent(Int.self, forKey: .id)
        let name = try container.decodeIfPresent(String.self, forKey: .name)
        let email = try container.decodeIfPresent(String.self, forKey: .email)
        let body = try container.decodeIfPresent(String.self, forKey: .body)
        
        self.init(postId: postId, id: id, name: name, email: email, body: body)
    }
}
