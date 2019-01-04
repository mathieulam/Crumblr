//
//  ApiManager.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 12/26/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    private init(){
        
    }
    
    //Returns a list of PhotosModel
    func getPhotos(success: @escaping ([PhotoModel]) -> (),
                   failure: @escaping (Error?) -> ()) {
        CrumblrApiService.getPhotoList(success: success, failure: failure)
    }
    
    //Returns a list of CommentModel
    func getComments(photoId: Int, success: @escaping ([CommentModel]) -> (),
                   failure: @escaping (Error?) -> ()) {
        CrumblrApiService.getCommentList(photoId: photoId, success: success, failure: failure)
    }
}
