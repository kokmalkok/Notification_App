//
//  CreatingGroupViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 14.12.2022.
//
//Задание: сделать вью с выбором цвета. Искать все в интернете. Цвет также меняет цвет изображения и цвет текста в текстовом поле
//сделать все ячейки круглыми как в корневом приложении
//Сделать вью с выбором изображения рядом с названием создаваемой группы. Тоже смотреть в интернете
//сделать ограничение по вводу букв в текстовом поле

import UIKit

protocol NewGroupDelegate: AnyObject{
    func passData(text string: String,color: UIColor,image: UIImage)
}

class CreatingGroupViewController: UIViewController {
    
    weak var delegate: NewGroupDelegate?
    
    private let dataArray = ["Black","Orange","Yellow","Blue","Light Blue","Red","Green","Indigo","Brown","White","Purple"]
    
    private let dataColorArray = [UIColor.blue, UIColor.systemRed, UIColor.systemMint, UIColor.systemYellow, UIColor.systemOrange, UIColor.systemBrown, UIColor.systemGreen, UIColor.black, UIColor.systemIndigo, UIColor.systemPurple]
    
    private let images = [UIImage(systemName: "car"),
                          UIImage(systemName: "wallet.pass"),
                          UIImage(systemName: "doc"),
                          UIImage(systemName: "trash"),
                          UIImage(systemName: "xmark"),
                          UIImage(systemName: "car"),
                          UIImage(systemName: "wallet.pass"),
                          UIImage(systemName: "doc"),
                          UIImage(systemName: "trash"),
                          UIImage(systemName: "xmark"),
                          UIImage(systemName: "xmark"),
                          UIImage(systemName: "car"),
                          UIImage(systemName: "wallet.pass"),
                          UIImage(systemName: "doc"),
                          UIImage(systemName: "trash"),
                          UIImage(systemName: "xmark"),
                          UIImage(systemName: "car"),
                          UIImage(systemName: "wallet.pass"),
                          UIImage(systemName: "doc"),
                          UIImage(systemName: "trash"),
                          UIImage(systemName: "xmark"),
                          UIImage(systemName: "xmark")]
    
    private let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    let customViewWithTextField: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    let imageViewInCustomView: UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 50
        image.image = UIImage(systemName: "list.bullet")
        image.image?.withTintColor(.systemBackground)
//        image.backgroundColor = .systemBlue
        return image
    }()
    
    let textFieldCustomView: UITextField = {
        let field = UITextField()
        field.backgroundColor = .tertiaryLabel
        field.layer.cornerRadius = 8
        field.font = .systemFont(ofSize: 26, weight: .regular)
        field.textAlignment = .center
        field.textColor = .black
        field.placeholder = "Title"
        return field
    }()
    
//    let delegateButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.configuration = .tinted()
//        button.configuration?.title = "Delegate "
//        button.configuration?.image = UIImage(systemName: "chevron.down")
//        button.configuration?.imagePadding = 8
//        button.configuration?.baseBackgroundColor = .systemOrange
//        button.configuration?.baseForegroundColor = .systemOrange
//        return button
//    }()
    
    let colorPickerView = UIPickerView()
    
    
    private var customCollectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupCollectionView()
        setupNavigationController()
        setupCustomView()
        setupMainView()
        setupPickerview()
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize = customViewWithTextField.frame.size.width/3
        let width = customViewWithTextField.frame.size.width
        let height = view.frame.size.height/3
        customViewWithTextField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+20, width: view.frame.size.width-40, height: height-60)
        imageViewInCustomView.frame = CGRect(x: imageSize, y: 30, width: imageSize, height: imageSize/1.5)
        textFieldCustomView.frame = CGRect(x: 20, y: imageSize+20, width: width-40, height: customViewWithTextField.frame.size.height/3-20)
        colorPickerView.frame = CGRect(x: 20, y: customViewWithTextField.frame.size.height+view.safeAreaInsets.top+40, width: width, height: height-100)
        customCollectionView.frame = CGRect(x: 20, y: customViewWithTextField.frame.size.height+view.safeAreaInsets.top+60+colorPickerView.frame.size.height, width: width, height: height)
    }

    @objc private func didTapDismiss(){
        self.dismiss(animated: true)
    }
    
    
    
    @objc private func didTapDone(){
            delegate?.passData(text: textFieldCustomView.text!, color: textFieldCustomView.textColor!, image: imageViewInCustomView.image!)
            dismiss(animated: true)
    }
    
    private func setupMainView(){
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(customViewWithTextField)
        view.addSubview(colorPickerView)
        self.view.addSubview(customCollectionView)
    }
    
    private func setupNavigationController(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDismiss))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        title = "New group list"
    }
    
    private func setupCustomView(){
        customViewWithTextField.addSubview(imageViewInCustomView)
        customViewWithTextField.addSubview(textFieldCustomView)
    }
    
    private func setupPickerview(){
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        colorPickerView.layer.cornerRadius = 8
        colorPickerView.layer.borderColor = UIColor.systemGray.cgColor
        colorPickerView.backgroundColor = .systemBackground
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSizeMake(50, 50)
        layout.sectionInset = UIEdgeInsets(top: 3, left:3, bottom: 3, right: 3)
        customCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        customCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        customCollectionView.layer.cornerRadius = 8
        customCollectionView.isUserInteractionEnabled = false
        customCollectionView.layer.borderColor = UIColor.systemGray.cgColor
        customCollectionView.backgroundColor = .systemBackground
        customCollectionView.contentInsetAdjustmentBehavior = .automatic
    }
}

extension CreatingGroupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowArray = dataArray[row]
        let image = imageViewInCustomView
        let textColor = textFieldCustomView
        if row == 0 {
            image.tintColor = .black
            textColor.textColor = .black
        } else if row == 1 {
            image.tintColor = .systemOrange
            textColor.textColor = .systemOrange
        } else if row == 2 {
            image.tintColor = .systemYellow
            textColor.textColor = .systemYellow
        } else if row == 3 {
            image.tintColor = .systemBlue
            textColor.textColor = .systemBlue
        } else if row == 4 {
            image.tintColor = .systemTeal
            textColor.textColor = .systemTeal
        } else if row == 5 {
            image.tintColor = .systemRed
            textColor.textColor = .systemRed
        } else if row == 6 {
            image.tintColor = .systemGreen
            textColor.textColor = .systemGreen
        } else if row == 7 {
            image.tintColor = .systemIndigo
            textColor.textColor = .systemIndigo
        } else if row == 8 {
            image.tintColor = .systemBrown
            textColor.textColor = .systemBrown
        } else if row == 9 {
            image.tintColor = .white
            textColor.textColor = .white
        } else if row == 10 {
            image.tintColor = .systemPurple
            textColor.textColor = .systemPurple
        }
        
        return rowArray
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let textColor = textFieldCustomView
        let image = imageViewInCustomView
        if row == 0 {
            image.tintColor = .black
            textColor.textColor = .black
        } else if row == 1 {
            image.tintColor = .systemOrange
            textColor.textColor = .systemOrange
        } else if row == 2 {
            image.tintColor = .systemYellow
            textColor.textColor = .systemYellow
        } else if row == 3 {
            image.tintColor = .systemBlue
            textColor.textColor = .systemBlue
        } else if row == 4 {
            image.tintColor = .systemTeal
            textColor.textColor = .systemTeal
        } else if row == 5 {
            image.tintColor = .systemRed
            textColor.textColor = .systemRed
        } else if row == 6 {
            image.tintColor = .systemGreen
            textColor.textColor = .systemGreen
        } else if row == 7 {
            image.tintColor = .systemIndigo
            textColor.textColor = .systemIndigo
        } else if row == 8 {
            image.tintColor = .systemBrown
            textColor.textColor = .systemBrown
        } else if row == 9 {
            image.tintColor = UIColor(red: 243, green: 185, blue: 124, alpha: 1)
            textColor.textColor = UIColor(red: 255, green: 174, blue: 102, alpha: 1)
        } else if row == 10 {
            image.tintColor = .systemPurple
            textColor.textColor = .systemPurple
        }
        
    }
}

extension CreatingGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        if let cellImage = images[indexPath.row], let imageColor = textFieldCustomView.textColor {
            cell.configure(with: cellImage, imageColor: imageColor)
            cell.backgroundColor = .systemBackground
            self.customCollectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selected item at \(indexPath.row)")
//        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        guard let image = cell.iconImageView.image else { return }
        imageViewInCustomView.image = image
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = .systemRed
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = .systemBackground
    }
}

//extension CreatingGroupViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSizeMake(50, 50)
//    }
//}
