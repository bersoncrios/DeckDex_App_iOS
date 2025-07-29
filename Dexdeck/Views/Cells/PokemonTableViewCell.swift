//
//  PokemonTableViewCell.swift
//  Dexdeck
//
//  Created by Familia Berson on 29/07/25.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    static let indentifier: String = "Card"

    //LABELS
    private lazy var cardEvoLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryColor
        label.text = "Basic"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secodaryColor
        label.text = "Celebi"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var cardTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.text = "Psychic"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var cardHPLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secodaryColor
        label.text = "50 HP"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var cardSuperTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.text = "Pokemon"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardEvoLevelLabel,
                                                        cardNameLabel,
                                                        cardTypeLabel,
                                                      ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8,
                                                                    leading: 8,
                                                                    bottom: 8,
                                                                    trailing: 8)
        return stackView
       }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardHPLabel,
                                                        cardSuperTypeLabel
                                                      ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8,
                                                                    leading: 8,
                                                                    bottom: 8,
                                                                    trailing: 8)
        return stackView
       }()
    
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftStackView,
                                                       rightStackView
                                                      ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                    leading: 16,
                                                                    bottom: 16,
                                                                    trailing: 16)
        return stackView
       }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
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
        ])
    }

}
