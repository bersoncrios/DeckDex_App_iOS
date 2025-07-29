//
//  SetsCollectionViewCell.swift
//  Dexdeck
//
//  Created by Familia Berson on 24/07/25.
//

import UIKit

class SetsCollectionViewCell: UICollectionViewCell {
    
    static let indentifier: String = "Sets"
    
    //IMAGES
    private lazy var setLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .setLogo
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var setIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .setIcon
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //LABELS
    private lazy var setNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.text = "Sword and Shield"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    
    //stack
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [setNameLabel,
                                                        setIcon,
                                                        setLogo])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 6, bottom: 12, trailing: 6)
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.secodaryColor?.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setHierarchy()
        setConstraints()
    }
            
    private func setHierarchy() {
        contentView.addSubview(stackView)
    }
            
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            setIcon.heightAnchor.constraint(equalToConstant: 11),
            
            setLogo.heightAnchor.constraint(equalToConstant: 15)

        ])
    }
}
