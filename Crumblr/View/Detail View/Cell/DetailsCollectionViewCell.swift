//
//  DetailsCollectionViewCell.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 1/2/19.
//  Copyright © 2019 Mathieu Lamvohee. All rights reserved.
//

import UIKit
import PureLayout

class DetailsCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Cell Reuse Identifier
    static let reuseIdentifier = "detailCell"
    
    //MARK: - Outlets
    let containerView: UIView = {
        let container = UIView.newAutoLayout()
        return container
    }()
    
    lazy var commentsTableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    //MARK: - Properties
    var didSetupConstraints = false
    let refreshControl = UIRefreshControl()
    var commentViewModels = [PhotoCommentViewModel]()
    var photoThumbnailViewModel: PhotoThumbnailViewModel! {
        didSet{
            fetchData()
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setupViews() {
        
        //Add Subviews
        self.addSubview(containerView)
        containerView.addSubview(commentsTableView)
        
        //TableView
        commentsTableView.register(ImageViewTableViewCell.self, forCellReuseIdentifier: ImageViewTableViewCell.reuseIdentifier)
        commentsTableView.register(PhotoTitleTableViewCell.self, forCellReuseIdentifier: PhotoTitleTableViewCell.reuseIdentifier)
        commentsTableView.register(PhotoCommentTableViewCell.self, forCellReuseIdentifier: PhotoCommentTableViewCell.reuseIdentifier)
        
        //Refresh Control
        refreshControl.addTarget(self, action: #selector(DetailsCollectionViewCell.refresh), for: .valueChanged)
        commentsTableView.addSubview(refreshControl)
        
        setNeedsUpdateConstraints()
    }
    
    @objc func refresh() {
        fetchData()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            //ContainerView Constraints
            containerView.autoPinEdge(toSuperviewEdge: .top)
            containerView.autoPinEdge(toSuperviewEdge: .leading)
            containerView.autoPinEdge(toSuperviewEdge: .trailing)
            containerView.autoPinEdge(toSuperviewEdge: .bottom)
            
            //TableView Constraints
            commentsTableView.autoPinEdge(toSuperviewEdge: .top)
            commentsTableView.autoPinEdge(toSuperviewEdge: .leading)
            commentsTableView.autoPinEdge(toSuperviewEdge: .trailing)
            commentsTableView.autoPinEdge(toSuperviewEdge: .bottom)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    fileprivate func fetchData(){
        if Reachability.isConnectedToNetwork(){
            guard let pictureId = photoThumbnailViewModel.photoId else {
                return
            }
            ApiManager.shared.getComments(photoId: pictureId, success: { (comments) in
                self.commentViewModels = comments.map({return PhotoCommentViewModel(comment: $0)})
                DispatchQueue.main.async {
                    self.commentsTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }) { (error) in
                if let error = error {
                    print("Failed to fetch photos: ", error)
                    return
                }
            }
        }else{
            self.refreshControl.endRefreshing()
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            guard let parentViewController = self.parentViewController else {
                return
            }
            parentViewController.present(alert, animated: true)
        }
    }
    
    
    //MARK: - TableView Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return commentViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageViewTableViewCell.reuseIdentifier, for: indexPath) as? ImageViewTableViewCell else {fatalError("Couldn't dequeue cell with identifier \(ImageViewTableViewCell.reuseIdentifier)")}
            imageCell.photoThumbnailViewModel = self.photoThumbnailViewModel
            return imageCell
        case 1:
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: PhotoTitleTableViewCell.reuseIdentifier, for: indexPath) as? PhotoTitleTableViewCell else {fatalError("Couldn't dequeue cell with identifier \(PhotoTitleTableViewCell.reuseIdentifier)")}
            titleCell.photoThumbnailViewModel = self.photoThumbnailViewModel
            return titleCell
        default:
            guard let commentCell = tableView.dequeueReusableCell(withIdentifier: PhotoCommentTableViewCell.reuseIdentifier, for: indexPath) as? PhotoCommentTableViewCell else {fatalError("Couldn't dequeue cell with identifier \(PhotoCommentTableViewCell.reuseIdentifier)")}
            commentCell.photoCommentViewModel = commentViewModels[indexPath.row]
            return commentCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 50
        default:
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            return 50
        }
    }
    
    //MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = commentsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ImageViewTableViewCell {
            cell.scrollViewDidScroll(scrollView: scrollView)
        }
    }
}
