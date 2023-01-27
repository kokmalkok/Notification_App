//
//  MainPageViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 14.12.2022.
//

import UIKit

//Разобраться с коллекциями и почему не работает нажатие

class MainPageViewController: UIViewController, NewGroupDelegate {

    let mainTableIdentifier = MainTableViewCell.identifier
    
    private let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    var cellArray: [String] = ["Check table view"]
    var cellData: [CellData] = [CellData(Title: "Hello", Image: UIImage(systemName: "bookmark")!, Color: .systemRed,Count: 0)]
    
    private var selectedCell = [String]()
    
    private var numberOfSelectedCells: Int {
        return groupTableView.indexPathForSelectedRow?.count ?? 0
    }
    
    var colorCell: [UIColor] = [.systemBackground]
    var imageInherit: [UIImage] = [UIImage(systemName: "bookmark.fill")!]
    
    private let todayButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBackground
        return button
    }()
    private let tomorrowButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBackground
        return button
    }()
    private let allNotButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBackground
        return button
    }()
    private let endedButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private let addNotificationButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName:"plus.circle"), for: .normal)
        button.currentImage?.withTintColor(.systemBlue)
        button.setTitle(" Notification", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let addNewGroupButton: UIButton = {
        let button = UIButton()
         button.setTitle("Add Group", for: .normal)
         button.layer.cornerRadius = 8
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .light)
         button.setTitleColor(.systemBlue, for: .normal)
         return button
    }()
    

    private let firstTextLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Today"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private  let secondTextLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Tomorrow"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private let thirdTextLabel: UILabel = {
       let label = UILabel()
        label.text = "All Notifications"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .tertiaryLabel
        return label
    }()
    private let forthTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Completed"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private let firstImage: UIImageView = {
       let image = UIImageView()
        image.image?.withTintColor(.secondarySystemBackground)
//        image.backgroundColor = .systemBlue
        image.image = UIImage(systemName: "xmark")
        return image
    }()
    
    private let secondImage: UIImageView = {
       let image = UIImageView()
        image.image?.withTintColor(.systemRed)
        image.image = UIImage(systemName: "calendar")
        return image
    }()
    
    private let thirdImage: UIImageView = {
       let image = UIImageView()
        image.image?.withTintColor(.black)
        image.image = UIImage(systemName: "folder")
        return image
    }()
    
    public let groupTableView: UITableView = {
       let table = UITableView()
        table.layer.cornerRadius = 8
        table.isScrollEnabled = false
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateNotification))
        setupView()
        setupButtonsTargets()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        editButtonItem.isEnabled = numberOfSelectedCells > 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let top = view.safeAreaInsets.top
        let count: CGFloat = CGFloat(cellArray.count)
        
    
        todayButton.frame = CGRect(x: 20, y: top+20, width: view.frame.size.width/2-30, height: 100)
        firstTextLabel.frame = CGRect(x: 10, y: 60, width: todayButton.frame.size.width-20, height: 30)
        firstImage.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        firstImage.layer.cornerRadius = 0.5 * firstImage.bounds.size.width
        
        tomorrowButton.frame = CGRect(x: view.frame.size.width/2+20, y: top+20, width: view.frame.size.width/2-40, height: 100)
        secondTextLabel.frame = CGRect(x: 10, y: 60, width: tomorrowButton.frame.size.width-20, height: 30)
        secondImage.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        secondImage.layer.cornerRadius = 0.5 * secondImage.bounds.size.width
        
        allNotButton.frame = CGRect(x: 20, y: top+40+todayButton.frame.size.height, width: view.frame.size.width/2-30, height: 100)
        thirdTextLabel.frame = CGRect(x: 10, y: 60, width: allNotButton.frame.size.width-20, height: 30)
        thirdImage.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        thirdImage.layer.cornerRadius = 0.5 * thirdImage.bounds.size.width
        
        endedButton.frame = CGRect(x: view.frame.size.width/2+20, y: top+40+todayButton.frame.size.height, width: view.frame.size.width/2-40, height: 100)
        forthTextLabel.frame = CGRect(x: 10, y: 60, width: endedButton.frame.size.width-20, height: 30)
        
        addNotificationButton.frame = CGRect(x: 10, y: view.frame.size.height-80, width: view.frame.size.width/2-20, height: 40)
        addNewGroupButton.frame = CGRect(x: view.frame.size.width/2+10, y: view.frame.size.height-80, width: view.frame.size.width/2+20, height: 40)
        
        groupTableView.frame = CGRect(x: 20, y: top+todayButton.frame.size.height+allNotButton.frame.size.height+80, width: view.frame.size.width-40, height: 60*count)
        
    }
    //MARK: - @objc targets
    
    @objc private func didTapCreateNotification(){
        let vc = UINavigationController(rootViewController: NoteNotificationViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        print("pressed add notification")
        
    }
    @objc private func didTapCreateNewGroup(){
        let vc = storyboardInstance.instantiateViewController(withIdentifier: "CreatingGroupViewController") as! CreatingGroupViewController
        let dest = UINavigationController(rootViewController: vc)
        let secVC = CreatingGroupViewController()
        vc.delegate = self
        dest.modalPresentationStyle = .formSheet
        present(dest, animated: true)
    }
    //MARK: - Alert popup
//    @objc private func didTapCreateNewGroup(){
//        let alert = UIAlertController(title: "New group", message: "Enter the title of group", preferredStyle: .alert)
//        alert.addTextField()
//        alert.addAction(UIAlertAction(title: "Submit", style: .cancel,handler: { [weak self] _ in
//            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
//            self?.cellArray.append(text)
//            self?.groupTableView.reloadData()
//            self?.groupTableView.frame.size.height += (self?.groupTableView.rowHeight)!
//
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
//        present(alert, animated: true)
//    }
    
    //MARK: - setup funcs and delegates
    func passData(text string: String, color: UIColor, image: UIImage) {
        cellArray.append(string)
        colorCell.append(color)
        imageInherit.append(image)
        groupTableView.frame.size.height += 60.0
        groupTableView.reloadData()
        
        cellData.append(CellData.init(Title: string, Image: image, Color: color,Count: 0))
    }
    
    private func setupView(){
        view.addSubview(todayButton)
        todayButton.addSubview(firstTextLabel)
        todayButton.addSubview(firstImage)
        
        view.addSubview(tomorrowButton)
        tomorrowButton.addSubview(secondImage)
        tomorrowButton.addSubview(secondTextLabel)
        
        view.addSubview(allNotButton)
        allNotButton.addSubview(thirdImage)
        allNotButton.addSubview(thirdTextLabel)
        
        view.addSubview(endedButton)
        endedButton.addSubview(forthTextLabel)
        
        view.addSubview(addNotificationButton)
        view.addSubview(addNewGroupButton)
        
        view.addSubview(groupTableView)
        //delegate from creatingGroupVC to MainPageVC
        let vc = CreatingGroupViewController()
        vc.delegate = self
    }
    private func setupButtonsTargets(){
        addNotificationButton.addTarget(self, action: #selector(didTapCreateNotification), for: .touchUpInside)
        addNewGroupButton.addTarget(self, action: #selector(didTapCreateNewGroup), for: .touchUpInside)
        }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,for: indexPath) as! MainTableViewCell
        cell.configureDataToCell(with: cellData[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
        
        

        
        
        //сделать цветовую палитру отображения изображения

//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
//        cell.textLabel?.text = cellArray[indexPath.row]
//        cell.imageView?.image = imageInherit[indexPath.row]
//        cell.imageView?.backgroundColor = colorCell[indexPath.row]
//        cell.imageView?.frame = CGRect(x: 5, y: 5, width: cell.contentview.frame.size.width-5, height: cell.contentView.frame.size.height-5)
//        cell.imageView!.layer.cornerRadius = 0.5 * cell.imageView!.bounds.size.width
//        cell.accessoryType = .disclosureIndicator
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //сделать переход при нажатии на группу при зажатии
    //сделать переход на пустой табличный вид
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        let destination = storyboard?.instantiateViewController(withIdentifier: "ListPageViewController") as! ListPageViewController
        let navigation = UINavigationController(rootViewController: destination)
        destination.titleView = cellArray[indexPath.row]
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .crossDissolve
        present(navigation, animated: true)

        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        cellArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.frame.size.height -= tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cellName = cellArray[indexPath.row]
        let actionEditInstance = UIContextualAction(style: .normal, title: "") { _, _, _ in
            let alert = UIAlertController(title: cellName, message: "Change title", preferredStyle: .alert)
            alert.addTextField()
            alert.textFields?.first?.text = cellName
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            alert.addAction(UIAlertAction(title: "Save", style: .cancel,handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
                self?.cellArray.remove(at: indexPath.row)
                self?.groupTableView.reloadData()
                self?.cellArray.append(text)
                self?.groupTableView.reloadData()
                
            }))
            self.present(alert, animated: true)
        }
        actionEditInstance.backgroundColor = .systemBlue
        actionEditInstance.image = UIImage(systemName: "info")
        actionEditInstance.image?.withTintColor(.systemBackground)
        let actionConfiguration = UISwipeActionsConfiguration(actions: [actionEditInstance])
        return actionConfiguration
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
}
