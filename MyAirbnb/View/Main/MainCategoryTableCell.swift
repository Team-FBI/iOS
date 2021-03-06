//
//  MainCategoryTableCell.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 08/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol MainCategoryTableCellDelegate: class {
    func pushView()
}

class MainCategoryTableCell: UITableViewCell {
    static let identifier = "mainCategoryTableCell"
    
    // MARK: - UI Properties
    let titleLabel = UILabel()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    // MARK: - Properties
    let collectionViewCellWidth: CGFloat = UIScreen.main.bounds.width * 0.35
    let notiCenter = NotificationCenter.default
    
    var categoryDataArray = [Category]()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MainCategoryTableCell.identifier)
        
        
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setLayout = false
    override func layoutSubviews() {
        if setLayout == false {
            setLayout = true
        }
    }
    
    private func setAutoLayout() {
        let topBottomMargin = StandardUIValue.shared.mainTableViewCellsTopBottomPadding
        let sideMargin = StandardUIValue.shared.mainViewSideMargin

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin).isActive = true
//        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1, constant: -sideMargin*2).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - sideMargin*3).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin*2).isActive = true
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewCellWidth+1).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func configureViewsOptions() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCategoryCollectCell.self, forCellWithReuseIdentifier: MainCategoryCollectCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: StandardUIValue.shared.mainViewSideMargin, bottom: 0, right: StandardUIValue.shared.mainViewSideMargin)
        
        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        titleLabel.configureMainTableViewCellsTitle()
        titleLabel.text = "MainCategoryTabelCell"
        titleLabel.sizeToFit()
//        titleLabel.text = "Jung Jin Alex님, 무엇을 찾고 계신가요?"
        titleLabel.text = "\(SingletonCommonData.shared.userInfo?.username ?? "")님, 무엇을 찾고 계신가요?"
//        titleLabel.font = .systemFont(ofSize: 21, weight: .bold)
    }
    
}

extension MainCategoryTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoryCollectCell.identifier, for: indexPath) as! MainCategoryCollectCell
        cell.setData(categoryDataArray[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewCellWidth, height: collectionViewCellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            notiCenter.post(name: .moveToHouseView, object: nil)
        case 1:
            notiCenter.post(name: .moveToTripViewController, object: nil)
        default: break
        }
    }
}
