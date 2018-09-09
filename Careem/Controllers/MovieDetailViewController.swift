//
//  MovieDetailViewController.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let posterImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let overviewLbl: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    
    init(movie: MovieDataModel) {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        configure(with: movie)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .black
        contentView.addSubviewsForAutolayout(posterImg, titleLbl, overviewLbl)
        scrollView.addSubviewsForAutolayout(contentView)
        view.addSubviewsForAutolayout(scrollView)
        setupConstraints()
    }
    
    private func configure(with movie: MovieDataModel) {
        titleLbl.text = movie.title
        overviewLbl.text = movie.overview
        posterImg.sd_addActivityIndicator()
        posterImg.sd_setImage(with: movie.posterUrl, placeholderImage: UIImage(named: "UserPlaceholder"), completed: nil)
    }
    
    private func setupConstraints() {
        let views = ["posterImg": posterImg,
                     "titleLbl": titleLbl,
                     "overviewLbl": overviewLbl,
                     "contentView": contentView,
                     "scrollView": scrollView]
        
        view.addConstraints(
            NSLayoutConstraint.constraints("H:|-40-[overviewLbl]-40-|", views: views),
            NSLayoutConstraint.constraints("H:|-40-[posterImg]-40-|", views: views),
            NSLayoutConstraint.constraints("H:|-40-[titleLbl]-40-|", views: views),
            NSLayoutConstraint.constraints("H:|-40-[scrollView]-40-|", views: views),
            NSLayoutConstraint.constraints("V:|[contentView]|", views: views),
            NSLayoutConstraint.constraints("V:|-10-[posterImg(300)]-10-[titleLbl]-10-[overviewLbl]-10-|", views: views),
            NSLayoutConstraint.constraints("V:|[scrollView]|", views: views))
        
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
