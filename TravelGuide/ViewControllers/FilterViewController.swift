//
//  FilterViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 15/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

struct CategoryModelCell {
    let image: String
    let name: String
    var isSelect: Bool
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    
    let cellID = "FilterCell"
    
    var categories: [CategoryModelCell] = {
        let cat_1 = CategoryModelCell(image: "selectAll", name: "Выбрать все", isSelect: true)
        let cat_2 = CategoryModelCell(image: "museum", name: "Музеи", isSelect: false)
        let cat_3 = CategoryModelCell(image: "galary", name: "Галереи", isSelect: false)
        let cat_4 = CategoryModelCell(image: "architecture", name: "Архитектура", isSelect: false)
        let cat_5 = CategoryModelCell(image: "religion", name: "Религия", isSelect: false)
        let cat_6 = CategoryModelCell(image: "theater", name: "Театры", isSelect: false)
        let cat_7 = CategoryModelCell(image: "entertainment", name: "Развлечения", isSelect: false)
        let cat_8 = CategoryModelCell(image: "sport", name: "Спорт", isSelect: false)
        let cat_9 = CategoryModelCell(image: "concert", name: "Концерты", isSelect: false)
        
        return [cat_1, cat_2, cat_3, cat_4, cat_5, cat_6, cat_7, cat_8, cat_9]
    }()
    
    var selectedCat: [CategoryModelCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FilterCollectionViewCell
        
        let category = categories[indexPath.row]
        cell.cellImage.image = UIImage(named: category.image)
        cell.nameLabel.text = category.name
        cell.selectCell(selectState: category.isSelect)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 10 - spacing between cells
        let cellWidth = collectionView.bounds.width / 3 - 10
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let state = self.categories[indexPath.row].isSelect
        self.categories[indexPath.row].isSelect = !state
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
            
            if indexPath.row == 0 {
                for index in 0 ..< categories.count {
                    categories[index].isSelect = false
                }
            } else {
                let firstCell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? FilterCollectionViewCell
                
                categories[0].isSelect = false
                firstCell?.selectCell(selectState: false)
                
                categories[indexPath.row].isSelect = !state
                cell.selectCell(selectState: !state)
            }
            
            if (categories.filter { $0.isSelect }.count == 0) {
                categories[0].isSelect = true
                collectionView.reloadData()
            }
        }
    }
}