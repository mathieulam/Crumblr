//
//  CrumblrApiService.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 12/26/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation

class CrumblrApiService {
    
    //Func that makes an api call and returns a list of PhotoModel
    static func getPhotoList(success: @escaping ((_ result: [PhotoModel]) -> ()),
                             failure: @escaping (Error?) -> ()) {
        
        guard let url = URL(string: CRUMBLR_BASE_URL_API) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let photoListModel = try JSONDecoder().decode([PhotoModel].self, from: data)
                let photoModels = photoListModel.sorted(by: { $0.title! < $1.title! })
                success(photoModels)
            } catch let jsonError {
                print("Error serializing json: ", jsonError)
            }
        }.resume()
    }
    
    //Func that makes an api call and returns a list of CommentModel
    static func getCommentList(photoId: Int,
                               success: @escaping ((_ result: [CommentModel]) -> ()),
                               failure: @escaping (Error?) -> ()) {
        
        let urlString = CRUMBLR_BASE_URL_API+"/\(photoId)/comments"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let commentListModel = try JSONDecoder().decode([CommentModel].self, from: data)
                var first20Comments = [CommentModel]()
                for commentModel in commentListModel[0...19] {
                    first20Comments.append(commentModel)
                }
                success(first20Comments)
            } catch let jsonError {
                print("Error serializing json: ", jsonError)
            }
        }.resume()
    }
}
