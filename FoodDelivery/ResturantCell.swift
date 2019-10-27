//
//  ResturantCell.swift
//  FoodDelivery
//
//  Created by Osama on 10/24/19.
//  Copyright © 2019 Osama Gamal. All rights reserved.
//

import UIKit

class ResturantCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var FoodGenreCollectionView: UICollectionView!
    var categories = ["American","Crep","Burgeer"]
    override func awakeFromNib() {
        super.awakeFromNib()
        FoodGenreCollectionView.delegate = self
        FoodGenreCollectionView.dataSource = self
        FoodGenreCollectionView.registerCellNib(cellClass: GenreCell.self)
        selectionStyle = .none

        //MARK :-
        // for enable self sizeing if items more than 2
        if categories.count > 2 {
          collectionViewLayout.estimatedItemSize = CGSize(width: 1,height: 1)
        }
       

    }
    
}

extension ResturantCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as GenreCell
        cell.categoryNameLabel.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //when items is 2 or less
         return CGSize(width: (collectionView.frame.size.width - 40)  / 2, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
}
