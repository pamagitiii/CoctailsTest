//
//  MainViewController.swift
//  coctailsTest
//
//  Created by Anatoliy on 28.03.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    var presenter: MainPresenter!
    private let collectionView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        collectionView.backgroundColor = .systemBlue
        setupUI()
        
        presenter.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.animation()
        }
    }
    
    private func setupUI() {
        
        view.addSubviews([collectionView])
        
        collectionView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }
    }
    
    private func animation() {
        UIView.animate(withDuration: 1) {
            
            self.collectionView.snp.removeConstraints()
            
            self.collectionView.snp.makeConstraints { make in
                make.height.equalTo(20)
                make.width.equalTo(400)

            }
            

            
            self.collectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(50)
                make.left.right.equalToSuperview().inset(30)
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension MainViewController: MainViewProtocol {
    
}
