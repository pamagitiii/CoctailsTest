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
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var tapGesture: UITapGestureRecognizer?
    private var tapView: UIView?
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Coctail name"
        textField.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupTextField()
        subscribeToKeyboardNotifications()
        presenter.viewDidLoad()
    }
    
    private func setupCollectionView() {
        collectionView.register(CustomCell.self)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchTextField.delegate = self
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        //layout.estimatedItemSize = CGSize(width: 100, height: 40)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.collectionViewLayout = layout
        
        view.addSubviews([collectionView, searchTextField])
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(5)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(5)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
        }
    }
    
    private func setupTextField() {
        searchTextField.snp.removeConstraints()

        searchTextField.backgroundColor = .white
        
        searchTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().inset(150)
            make.height.equalTo(30)
        }
        
        searchTextField.layer.masksToBounds = false
        searchTextField.layer.cornerRadius = 8
        
        searchTextField.layer.shadowOpacity = 0.3
        searchTextField.layer.shadowRadius = 8
        searchTextField.layer.shadowOffset = .zero
        searchTextField.layer.shadowColor = UIColor.black.cgColor
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCellatIndex(indexPath.item)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //лэйбл для высчитывания размера ячейки
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 12)
        label.text = presenter.coctails[indexPath.row]
        label.sizeToFit()
        let size = label.frame.size
        return CGSize(width: size.width + 20, height: 25)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.coctails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: CustomCell.self, for: indexPath)
        cell.setup(presenter.coctails[indexPath.item])
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8

        
        if presenter.selected.contains(presenter.coctails[indexPath.item])
        {
            cell.contentView.backgroundColor = UIColor(red: 252/255, green: 53/255, blue: 155/255, alpha: 1)
        } else {
            cell.contentView.backgroundColor = .systemGray3
        }
        
        return cell
    }
}

private extension MainViewController {
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
                
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardTop = keyboardSize.height
        self.searchTextField.layer.cornerRadius = 0
        
        UIView.animate(withDuration: 0.3) {
            self.searchTextField.snp.removeConstraints()
            self.searchTextField.snp.makeConstraints { make in
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalToSuperview()
                make.bottom.equalToSuperview().inset(keyboardTop + 1)
                make.height.equalTo(30)
            }
            self.view.layoutIfNeeded()
        }
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        tapView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - keyboardSize.height - 31))
        tapView?.addGestureRecognizer(tapGesture!)
        tapView?.backgroundColor = .clear
        
        view.addSubview(tapView!)
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        setupTextField()

        tapView?.removeGestureRecognizer(tapGesture!)
        tapView?.removeFromSuperview()
        tapView = nil
        tapGesture = nil
        
        print(tapView)
        print(tapGesture)

        
        
    }
    
    @objc private func endEdit() {
        view.endEditing(true)
        

        
    }
}

extension MainViewController: UITextFieldDelegate {
    
}


extension MainViewController: MainViewProtocol {
    func updateItems(at index: Int) {
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        
    }
    
    func didLoadData() {
        collectionView.reloadData()
    }
    
    
}
