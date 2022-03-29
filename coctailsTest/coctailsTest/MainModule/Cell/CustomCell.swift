//
//  CustomCell.swift
//  coctailsTest
//
//  Created by Anatoliy on 29.03.2022.
//

import UIKit
import SnapKit

class CustomCell: UICollectionViewCell {
    
//    var isNeedsGradient = false
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray3
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        label.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }

//        if !(contentView.layer.sublayers?.first is CAGradientLayer ) &&  isNeedsGradient {
//            gradi()
//        }
    }
    
    func setup(_ text: String) {
        label.text = text
    }
    
    func gradi() {
        let gradient = CAGradientLayer()
               gradient.frame = contentView.bounds
               gradient.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
               gradient.startPoint = CGPoint(x: 0, y: 1)
               gradient.endPoint = CGPoint(x: 1, y: 0)
               contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if  (contentView.layer.sublayers?.first != nil) && (contentView.layer.sublayers?.first is CAGradientLayer ) {
            contentView.layer.sublayers?.removeFirst()
        }
    }
}
