//
//  DynamicCollectionView.swift
//  FoodDelivery
//
//  Created by prog_zidane on 10/27/19.
//  Copyright © 2019 Osama Gamal. All rights reserved.
//

import Foundation
import UIKit


class DynamicCollectionView: UICollectionView {
  override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
        self.invalidateIntrinsicContentSize()
     }
  }
   override var intrinsicContentSize: CGSize {
    return collectionViewLayout.collectionViewContentSize
   }
}
