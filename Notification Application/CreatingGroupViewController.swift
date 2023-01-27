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
  //MARK: - Main Variables and constants 
    weak var delegate: NewGroupDelegate? //делегат протокола для передачи данных в MainPageVC
    
    var colorOfItems = UIColor.systemBlue//трансфер для передачи цвета из MainPage чтобы не было ошибки. Также при сохранении
    
    private let groupCoreData = GroupListStack()//наследование хранилища
    
    private let collectionImages = [UIImage(systemName: "car.fill"),
                          UIImage(systemName: "wallet.pass.fill"),
                          UIImage(systemName: "doc.fill"),
                          UIImage(systemName: "trash.fill"),
                          UIImage(systemName: "xmark"),
                          UIImage(systemName: "list.clipboard"),
                          UIImage(systemName: "list.number"),
                          UIImage(systemName: "pin.fill"),
                          UIImage(systemName: "circle"),
                          UIImage(systemName: "pencil.circle.fill"),
                          UIImage(systemName: "pencil.and.ruler.fill"),
                          UIImage(systemName: "bookmark.fill"),
                          UIImage(systemName: "birthday.cake.fill"),
                          UIImage(systemName: "bag.fill"),
                          UIImage(systemName: "camera.fill"),
                          UIImage(systemName: "book.fill"),
                          UIImage(systemName: "car"),
                          UIImage(systemName: "wallet.pass"),
                          UIImage(systemName: "creditcard.fill"),
                          UIImage(systemName: "dumbbell.fill"),
                          UIImage(systemName: "figure.run.circle.fill"),
                          UIImage(systemName: "wineglass.fill"),
                          UIImage(systemName: "pills.fill"),
                          UIImage(systemName: "medical.thermometer.fill"),
                          UIImage(systemName: "bed.double.fill"),
                          UIImage(systemName: "house.fill"),
                          UIImage(systemName: "building.fill"),
                          UIImage(systemName: "laptopcomputer"),
                          UIImage(systemName: "music.note.house.fill"),
                          UIImage(systemName: "gamecontroller.fill"),
                          UIImage(systemName: "headphones"),
                          UIImage(systemName: "person.fill"),
                          UIImage(systemName: "person.2.fill"),
                          UIImage(systemName: "person.3.fill"),
                          UIImage(systemName: "pawprint.fill"),
                          UIImage(systemName: "soccerball")]
    
    private let colorCollections = [UIColor.systemRed,
                                    UIColor.systemBlue,
                                    UIColor.systemYellow,
                                    UIColor.systemGray,
                                    UIColor.systemGreen,
                                    UIColor.systemOrange,
                                    UIColor.systemPink,
                                    UIColor.systemIndigo,
                                    UIColor.systemMint,
                                    UIColor.systemBrown,
                                    UIColor.black,
                                    UIColor.systemPurple]
 //MARK: Visual Elements
    let customViewWithTextField: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    let imageViewInCustomView: UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 50
        image.image = UIImage(systemName: "list.clipboard.fill")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemBackground
        image.tintColor = .systemBlue
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
        field.autocorrectionType = .no
        field.autocapitalizationType = .words
        return field
    }()
    
    private let confirmDataButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapDone))
    private let colorPickerButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(didTapSelectColor))
    
    private var imageCollectionView: UICollectionView!
    private var colorCollectionView: UICollectionView!
    
//MARK: Displaying Data Main Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupImageCollectionView()
        setupColorCollectionView()
        setupNavigationController()
        setupCustomView()
        setupMainView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize = customViewWithTextField.frame.size.width/4
        let width = customViewWithTextField.frame.size.width
        let height = view.frame.size.height/3
        customViewWithTextField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+20, width: view.frame.size.width-40, height: height-60)
        imageViewInCustomView.frame = CGRect(x: customViewWithTextField.frame.size.width/2-imageSize/2, y: 30, width: imageSize, height: imageSize)
        imageViewInCustomView.layer.cornerRadius = 0.5 * imageViewInCustomView.bounds.width
        textFieldCustomView.frame = CGRect(x: 20, y: imageSize*1.5, width: width-40, height: customViewWithTextField.frame.size.height/3-20)
        colorCollectionView.frame = CGRect(x: 20, y: customViewWithTextField.frame.size.height+view.safeAreaInsets.top+40, width: width, height: 120)
        imageCollectionView.frame = CGRect(x: 20, y: customViewWithTextField.frame.size.height+view.safeAreaInsets.top+40+colorCollectionView.frame.size.height+20, width: width, height: height)
    }
//MARK: Objc methods
    @objc private func didTapDismiss(){
        if let text = textFieldCustomView.text, !text.isEmpty {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive,handler: { _ in
                self.dismiss(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        } else {
            self.dismiss(animated: true)
        }
        
    }
    
    @objc private func didTapDone(){
        if let text = textFieldCustomView.text, !text.isEmpty {
            delegate?.passData(text: textFieldCustomView.text ?? "Empty notification", color: colorOfItems, image: imageViewInCustomView.image!)
            dismiss(animated: true)
        } else {
            //добавить попап алерт о том что нужно ввести текст для сохранения группы
            let alert = UIAlertController(title: "Warning!", message: "Enter some text to create new notification", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fine", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc private func didTapSelectColor(){
        let colorPickerImageView = UIColorPickerViewController()
        colorPickerImageView.accessibilityContainerType = .list
        colorPickerImageView.isModalInPresentation = true
        colorPickerImageView.delegate = self
        colorPickerImageView.supportsAlpha = false
        colorPickerImageView.modalPresentationStyle = .pageSheet
        colorPickerImageView.sheetPresentationController?.detents = [.medium(),.large()]
        colorPickerImageView.sheetPresentationController?.prefersGrabberVisible = true
        colorPickerImageView.title = "Text & Image color"
        present(colorPickerImageView,animated: true)
    }
//MARK: Setups Methods
    private func setupMainView(){
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(customViewWithTextField)
        view.addSubview(imageCollectionView)
        view.addSubview(colorCollectionView)

    }
    
    private func setupNavigationController(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDismiss))
        navigationItem.rightBarButtonItems = [confirmDataButton,colorPickerButton]
        title = "New group list"
    }
    
    private func setupCustomView(){
        customViewWithTextField.addSubview(imageViewInCustomView)
        customViewWithTextField.addSubview(textFieldCustomView)
    }
    
    private func setupImageCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSizeMake(50, 50)
        layout.sectionInset = UIEdgeInsets(top: 3, left:3, bottom: 3, right: 3)
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        imageCollectionView.layer.cornerRadius = 8
        imageCollectionView.isUserInteractionEnabled = true
        imageCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        imageCollectionView.backgroundColor = .systemBackground
        imageCollectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupColorCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
        colorCollectionView.layer.cornerRadius = 8
        colorCollectionView.isUserInteractionEnabled = true
        colorCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        colorCollectionView.backgroundColor = .systemBackground
        colorCollectionView.contentInsetAdjustmentBehavior = .always
    }
}
//MARK: EXTENSIONS
extension CreatingGroupViewController: UIColorPickerViewControllerDelegate {
 
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        let textColor = textFieldCustomView
        let image = imageViewInCustomView
        let encode = color.encode()
        let decode = UIColor.color(withData: encode!)
        image.tintColor = decode
        textColor.textColor = decode
        colorOfItems = decode ?? .systemBlue
    }
}


extension CreatingGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.imageCollectionView {
            return collectionImages.count
        }
        return colorCollections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.colorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
            let color = colorCollections[indexPath.row]
            cell.configure(with: color)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
            let image = collectionImages[indexPath.row]
            cell.configure(with: image!, imageColor: colorOfItems)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == self.colorCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! ColorCollectionViewCell
            guard let color = cell.colorImageView.backgroundColor else { return }
            let image = imageViewInCustomView
            let textColor = textFieldCustomView
            image.tintColor = color
            textColor.textColor = color
            cell.colorImageView.image?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
            colorOfItems = color
            
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
            guard let image = cell.iconImageView.image else { return }
            imageViewInCustomView.image = image
        }
    }
}
