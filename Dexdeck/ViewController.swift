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
        label.text = "TCG Coleções"
        label.textColor = .textColor
        return label
    }()
    
    private lazy var pokedexSectionTitleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "TCG Cartas"
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
    
    private lazy var pookedexCardTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.indentifier)
        return tableView
    }()
    
    private let service = Service()
    private var tcgResponse: TCGResponse?
    private var tcgColecoes: TCGColecoes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
        fetchColecoesData()
    }
    
    private func fetchData() {
        service.fetchAllCards { [weak self] response in
            self?.tcgResponse = response
            DispatchQueue.main.async {
                self?.loadData()
            }
        }
    }
    
    private func fetchColecoesData() {
        service.fetchAllColecoes{ [weak self] response in
            self?.tcgColecoes = response
            DispatchQueue.main.async {
                self?.loadColecoesData()
            }
        }
    }
    
    
    private func loadData() {
        if let response = tcgResponse {
            DispatchQueue.main.async {
                self.pookedexCardTableView.reloadData()
            }
        } else {
            print("tcgResponse é nil")
        }
    }
    
    private func loadColecoesData() {
        if let response = tcgColecoes {
            DispatchQueue.main.async {
                self.setCollectionView.reloadData()
            }
        } else {
            print("tcgColecoes é nil")
        }
    }
    
    private func setupView(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        view.addSubview(backgroundView)
        view.addSubview(setSectionTitleLable)
        view.addSubview(setCollectionView)
        view.addSubview(pokedexSectionTitleLable)
        view.addSubview(pookedexCardTableView)
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
        
        NSLayoutConstraint.activate([
            pokedexSectionTitleLable.topAnchor.constraint(equalTo: setCollectionView.bottomAnchor, constant: 45),
            pokedexSectionTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            pokedexSectionTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
        ])
        
        NSLayoutConstraint.activate([
            pookedexCardTableView.topAnchor.constraint(equalTo: pokedexSectionTitleLable.bottomAnchor, constant: 20),
            pookedexCardTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pookedexCardTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            pookedexCardTableView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
    }
    
}

//MARK: Collection Data Source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tcgColecoes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SetsCollectionViewCell.indentifier,
                                                            for: indexPath) as? SetsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let sets = tcgColecoes?.data[indexPath.row]
        cell.loadDataSets(
            name: sets?.name,
            icon: sets?.images.symbol,
            logo: sets?.images.logo)
        return cell
    }
}

//MARK: Table View Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tcgResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.indentifier,
                                                       for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokedex = tcgResponse?.data[indexPath.row]
        cell.loadDataToScreen(
            name: pokedex?.name,
            cardHp: pokedex?.hp
        )
        
        return cell
    }
}
