//
//  PhotoCommentViewModel.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 1/3/19.
//  Copyright © 2019 Mathieu Lamvohee. All rights reserved.
//

import Foundation

struct PhotoCommentViewModel {
    let title: String?
    let emailAddress: String?
    let description: String?
    
    
    //Dependency Injection
    init(comment: CommentModel) {
        self.title = comment.name
        self.emailAddress = comment.email
        self.description = comment.body
    }
}
