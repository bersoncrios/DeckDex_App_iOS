//
//  ViewController.swift
//  Dexdeck
//
//  Created by Familia Berson on 24/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    // IMAGES
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backgroundApp
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //LABELS
    private lazy var setSectionTitleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "TCG SETS"
        label.textColor = .textColor
        return label
    }()
    
    
    //COLLECTIONS VIEWS
    private lazy var setCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 125, height: 85)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 6, bottom: .zero, right: 6)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(SetsCollectionViewCell.self, forCellWithReuseIdentifier: SetsCollectionViewCell.indentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        view.addSubview(backgroundView)
        view.addSubview(setSectionTitleLable)
        view.addSubview(setCollectionView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            setSectionTitleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            setSectionTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            setSectionTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
        ])
        
        NSLayoutConstraint.activate([
            setCollectionView.topAnchor.constraint(equalTo: setSectionTitleLable.bottomAnchor, constant: 20),
            setCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            setCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            setCollectionView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SetsCollectionViewCell.indentifier, for: indexPath)
        return cell
    }
    
    
}
