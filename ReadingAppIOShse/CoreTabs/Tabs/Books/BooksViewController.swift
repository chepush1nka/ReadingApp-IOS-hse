//
//  HomeViewController.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 24.11.2022.
//

import UIKit

class BooksViewController: UIViewController {
    
    private let sections: [Section] = [
        Section(
            type: "recommendedBooks",
            title: "Recommended",
            items: [
                "Sink_or_Swim-Andy_Cowle",
                "Supermodels-Vicky_Shipton",
                "Barchester_Towers-Anthony_Trollope",
                "Jack_the_Ripper-Foreman_Peter",
            ]
        ),
        Section(
            type: "allBooks",
            title: "All books",
            items: [
                "Breakfast_at_Tiffanys-Truman_Capote",
                "Muhammad_Ali-B_Smith",
                "Message_in_a_Bottle-Nicholas_Sparks",
                "Mine_Boy-Peter_Abrahams",
                "The_Magician-W_Somerset_Maugham",
            ]
        )
    ]
    
    private var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(BookVerticalCell.self, forCellWithReuseIdentifier: BookVerticalCell.reuseId)
        
        collectionView.register(RecommendedBooksCell.self, forCellWithReuseIdentifier: RecommendedBooksCell.reuseId)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader ,withReuseIdentifier: SectionHeader.reuseId)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, book) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].type {
            case "recommendedBooks":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedBooksCell.reuseId,
                                                              for: indexPath) as? RecommendedBooksCell
                cell?.configure(with: book)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookVerticalCell.reuseId,
                                                              for: indexPath) as? BookVerticalCell
                cell?.configure(with: book)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return nil }
            guard let firstChat = self.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstChat) else { return nil }
            if section.title.isEmpty { return nil }
            
            sectionHeader.title.text = section.title
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case "recommendedBooks":
                return self.createRecommendedBooksSection()
            default:
                return self.createAllBooksSection()
            }
        }
        
        return layout
    }
    
    private func createRecommendedBooksSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(163.0), heightDimension: .estimated(290))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 17, bottom: 0, trailing: 0)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createAllBooksSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(150))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 17, bottom: 0, trailing: 30)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHEaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHEaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
    
    
    
}

extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedBooksCell.reuseId, for: indexPath) as! RecommendedBooksCell
            return cell
        }
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookVerticalCell.reuseId, for: indexPath) as! BookVerticalCell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = sections[indexPath.section].items[indexPath.item]
        let vc = BookDescriptionSheet()
        vc.configure(with: book)
        
        self.present(vc, animated: true)
    }
}

