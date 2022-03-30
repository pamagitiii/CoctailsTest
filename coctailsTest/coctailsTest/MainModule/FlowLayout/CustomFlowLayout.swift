//
//  CustomFlowLayout.swift
//  coctailsTest
//
//  Created by Anatoliy on 29.03.2022.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
    //вторая версия лэйаута

//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//
//        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)!
//
//        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
//
//        var leftMargin: CGFloat = 0.0
//
//        for attributes in attributesForElementsInRect {
//            let refAttributes = attributes
//
//            if (refAttributes.frame.origin.x == self.sectionInset.left) {
//                leftMargin = self.sectionInset.left
//            } else {
//                var newLeftAlignedFrame = refAttributes.frame
//                newLeftAlignedFrame.origin.x = leftMargin
//                refAttributes.frame = newLeftAlignedFrame
//            }
//            leftMargin += refAttributes.frame.size.width + 10
//            newAttributesForElementsInRect.append(refAttributes)
//        }
//        return newAttributesForElementsInRect
//    }

