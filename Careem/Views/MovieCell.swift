//
//  MovieCell.swift
//  Careem
//
//  Created by Arnaldo on 9/4/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import SDWebImage

class MovieCell: UICollectionViewCell {
    private let thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.clipsToBounds = true
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.layer.cornerRadius = 10
        return thumbnail
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        return label
    }()
    private let votes: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return label
    }()
    private let overview: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return label
    }()
    private let relaseDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .mainGray
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return label
    }()
    private let nameBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    static let defaultIdentifier = "MovieCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviewsForAutolayout(thumbnail, nameBackground,
                                             title, votes, relaseDate, overview)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["thumbnail": thumbnail,
                                    "name": title,
                                    "votes": votes,
                                    "nameBackground": nameBackground,
                                    "releaseDate": relaseDate,
                                    "overview": overview]
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints("H:|-0.5-[thumbnail]-0.5-|", views: views),
            NSLayoutConstraint.constraints("H:|-5-[name]-5-|", views: views),
            NSLayoutConstraint.constraints("H:|[nameBackground]|", views: views),
            NSLayoutConstraint.constraints("H:[votes]-5-|", views: views),
            NSLayoutConstraint.constraints("H:|-5-[releaseDate]-5-|", views: views),
            NSLayoutConstraint.constraints("H:|-5-[overview]-5-|", views: views),
            NSLayoutConstraint.constraints("V:|-0.5-[thumbnail]-0.5-|", views: views),
            NSLayoutConstraint.constraints("V:|-5-[votes]", views: views),
            NSLayoutConstraint.constraints("V:[nameBackground]|", views: views),
            NSLayoutConstraint.constraints("V:[name][releaseDate][overview]-5-|", views: views))
        
        nameBackground.topAnchor.constraint(equalTo: title.topAnchor, constant: -5).isActive = true
    }
    
    func configure(with movie: MovieDataModel) {
        title.text = movie.title
        votes.text = movie.votes
        relaseDate.text = movie.releaseDate
        overview.text = movie.overview
        thumbnail.sd_addActivityIndicator()
        thumbnail.sd_setImage(with: movie.posterUrl, placeholderImage: UIImage(named: "UserPlaceholder"), completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
    }
}
