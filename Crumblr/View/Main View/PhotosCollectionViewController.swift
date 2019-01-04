//
//  ViewController.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 12/24/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //MARK: - Properties
    var photoThumbnailViewModels = [PhotoThumbnailViewModel]()
    let refreshControl = UIRefreshControl()
    
    //MARK: - CollectionViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.lightGray
        collectionView?.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier)
        refreshControl.addTarget(self, action: #selector(DetailsCollectionViewCell.refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        fetchData()
    }
    
    //MARK: - Methods
    fileprivate func fetchData(){
        if Reachability.isConnectedToNetwork(){
            ApiManager.shared.getPhotos(success: { (photoList) in
                self.photoThumbnailViewModels = photoList.map({return PhotoThumbnailViewModel(photo: $0)})
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.collectionView?.reloadData()
                }
            }) { (error) in
                if let error = error {
                    print("Failed to fetch photos: ", error)
                    return
                }
            }
        } else {
            self.refreshControl.endRefreshing()
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func refresh() {
        fetchData()
    }
    
    //MARK: - CollectionViewController Data Source
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotosCollectionViewCell
            else {fatalError("Couldn't dequeue cell with identifier \(PhotosCollectionViewCell.reuseIdentifier)")}
        let photoThumbnailViewModel = photoThumbnailViewModels[indexPath.row]
        cell.photoThumbnailViewModel = photoThumbnailViewModel
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoThumbnailViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = collectionView.frame.width / 3.0 - 10.0
        return CGSize(width: itemWidth, height: itemWidth * 1.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let flowLayout = UICollectionViewFlowLayout()
        let detailsViewController = DetailsViewController(collectionViewLayout: flowLayout)
        detailsViewController.photoViewModels = photoThumbnailViewModels
        detailsViewController.selectedIndexPath = indexPath
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

