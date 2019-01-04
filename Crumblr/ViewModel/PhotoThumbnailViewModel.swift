//
//  PhotoListViewModel.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 12/31/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation

struct PhotoThumbnailViewModel {
    let photoId: Int?
    let imageURL: String?
    let title: String?
    
    
    //Dependency Injection
    init(photo: PhotoModel) {
        self.photoId = photo.id
        self.imageURL = photo.thumbnailUrl
        self.title = photo.title
    }
}
