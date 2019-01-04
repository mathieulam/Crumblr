//
//  PhotoModel.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 12/26/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation


struct PhotoModel: Codable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    
    init(albumId: Int?, id: Int?, title: String?, url: String?, thumbnailUrl: String?) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
    enum PhotoModelKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoModelKeys.self)
        let albumId = try container.decodeIfPresent(Int.self, forKey: .albumId)
        let id = try container.decodeIfPresent(Int.self, forKey: .id)
        let title = try container.decodeIfPresent(String.self, forKey: .title)
        let url = try container.decodeIfPresent(String.self, forKey: .url)
        let thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        
        self.init(albumId: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)
    }
}
