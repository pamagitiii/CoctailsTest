//
//  CustomCell.swift
//  coctailsTest
//
//  Created by Anatoliy on 29.03.2022.
//

import UIKit
import SnapKit

class CustomCell: UICollectionViewCell {
    
    //MARK: - proprties
    var isNeedsGradient = false
    
    private var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray3
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }

        if isNeedsGradient {
            gradient.frame = contentView.bounds
            addGradient()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isNeedsGradient = false
        if contentView.layer.sublayers?.count != nil && contentView.layer.sublayers!.count > 1 {
            contentView.layer.sublayers?.remove(at: 0)
        }
    }
    
    //MARK: - methods
    func setup(_ text: String) {
        label.text = text
    }
    
    private func addGradient() {
            self.contentView.layer.insertSublayer(self.gradient, at: 0)
    }
}
