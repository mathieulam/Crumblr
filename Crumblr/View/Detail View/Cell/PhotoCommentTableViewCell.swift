//
//  PhotoCommentTableViewCell.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 1/2/19.
//  Copyright © 2019 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class PhotoCommentTableViewCell: UITableViewCell {

    //MARK: - Cell Reuse Identifier
    static let reuseIdentifier = "photoCommentCell"
    
    //MARK: - Outlets
    let containerView: UIView = {
        let container = UIView.newAutoLayout()
        return container
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel.newAutoLayout()
        titleLabel.font = titleLabel.font.withSize(15)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    let emailAddressLabel: UILabel = {
        let emailLabel = UILabel.newAutoLayout()
        emailLabel.font = emailLabel.font.withSize(13)
        emailLabel.numberOfLines = 1
        return emailLabel
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel.newAutoLayout()
        descriptionLabel.font = descriptionLabel.font.withSize(15)
        descriptionLabel.numberOfLines = 2
        return descriptionLabel
    }()
    
    //MARK: - Properties
    var didSetupConstraints = false
    var photoCommentViewModel: PhotoCommentViewModel! {
        didSet{
            if let title = photoCommentViewModel.title {
                titleLabel.text = title
            }
            if let email = photoCommentViewModel.emailAddress {
                emailAddressLabel.text = email
            }
            if let description = photoCommentViewModel.description {
                descriptionLabel.text = description
            }
        }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Methods
    
    func setupViews() {
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(emailAddressLabel)
        containerView.addSubview(descriptionLabel)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            //ContainerView Constraints
            containerView.autoPinEdge(toSuperviewEdge: .top)
            containerView.autoPinEdge(toSuperviewEdge: .leading)
            containerView.autoSetDimension(.width, toSize: UIScreen.main.bounds.size.width)
            containerView.autoPinEdge(toSuperviewEdge: .bottom)
            containerView.layoutMargins = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
            
            //Title Label Constraints
            titleLabel.preservesSuperviewLayoutMargins = true
            titleLabel.autoPinEdge(toSuperviewEdge: .top)
            titleLabel.autoPinEdge(toSuperviewEdge: .leading)
            titleLabel.autoPinEdge(toSuperviewEdge: .trailing)
            titleLabel.autoSetDimension(.height, toSize: 30)
            
            //Email Label Constraints
            emailAddressLabel.preservesSuperviewLayoutMargins = true
            emailAddressLabel.autoPinEdge(toSuperviewEdge: .leading)
            emailAddressLabel.autoPinEdge(toSuperviewEdge: .trailing)
            emailAddressLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 5)
            emailAddressLabel.autoSetDimension(.height, toSize: 30)
            
            //Description Label Constraints
            descriptionLabel.preservesSuperviewLayoutMargins = true
            descriptionLabel.autoPinEdge(toSuperviewEdge: .leading)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .bottom)
            descriptionLabel.autoPinEdge(.top, to: .bottom, of: emailAddressLabel, withOffset: 5)
            descriptionLabel.autoSetDimension(.height, toSize: 45)
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
}
