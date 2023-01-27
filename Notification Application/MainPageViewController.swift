//
//  MainPageViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 14.12.2022.
//

import UIKit
import UserNotifications


class MainPageViewController: UIViewController {
    
    private let coreData = GroupListStack.instance
    private let coreDataNotifications = NotificationsDataStack.instance
    private let coreDataCategory = CategoryDataStack.instance
    
    private let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)//ссылочное наследование сториборда
    
    var dictionaryData: [String:[NotificationData]] = [:] //словарь структур данных для хранения названия и массива напоминаний
    
    var mainDictionaryData: [String: [NotificationsEntity]] = [:] //попытка сохранить данные в словарь и выгружать потом его при помощи CoreData
    
    
    var cellIndexPath: Int? = nil //используется для проверки дублируемости при редактировании строки
    var cellIndexForMenu: IndexPath?
    
    private var numberOfSelectedCells: Int {
        return groupTableView.indexPathForSelectedRow?.count ?? 0
    }
    
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
        button.setImage(UIImage(systemName:"plus"), for: .normal)
        button.currentImage?.withTintColor(.systemBackground)
        button.setTitle(" Notification", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let addNewGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Group", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
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
        image.image = UIImage(systemName: "calendar.badge.clock")
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let secondImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .systemOrange
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let thirdImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "archivebox.fill")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let forthImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.tintColor = .darkGray
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    public let groupTableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 8
        table.isScrollEnabled = false
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return table
    }()
    
    private let labelCountToday: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let labelCountTomorrow: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let labelCountAll: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        
        setupView()
        setupButtonsTargets()
        cellCount(count: coreData.groupVaultData.count)
        coreData.loadDataGroupEntity()
        coreDataNotifications.loadNotificationDataEntity()
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setDictionaryData(group: coreData.groupVaultData, list: coreDataNotifications.notificationVaultData)
        //        if coreData.groupVaultData.count == 0 {
        //            print("data is empty")
        //        } else {
        //            setDictionaryData(group: coreData.groupVaultData, list: coreDataNotifications.notificationVaultData)
        //        }
        
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        editButtonItem.isEnabled = numberOfSelectedCells > 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let top = view.safeAreaInsets.top
        let count: CGFloat = CGFloat(coreData.groupVaultData.count)
        
        todayButton.frame = CGRect(x: 20, y: top+20, width: view.frame.size.width/2-30, height: 100)
        firstTextLabel.frame = CGRect(x: 10, y: 60, width: todayButton.frame.size.width-20, height: 30)
        firstImage.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        labelCountToday.frame = CGRect(x: todayButton.frame.size.width-50, y: 10, width: 40, height: 40)
        
        tomorrowButton.frame = CGRect(x: view.frame.size.width/2+20, y: top+20, width: view.frame.size.width/2-40, height: 100)
        secondTextLabel.frame = CGRect(x: 10, y: 60, width: tomorrowButton.frame.size.width-20, height: 30)
        secondImage.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        labelCountTomorrow.frame = CGRect(x: tomorrowButton.frame.size.width-50, y: 10, width: 40, height: 40)
        
        
        allNotButton.frame = CGRect(x: 20, y: top+40+todayButton.frame.size.height, width: view.frame.size.width/2-30, height: 100)
        thirdTextLabel.frame = CGRect(x: 10, y: 60, width: allNotButton.frame.size.width-20, height: 30)
        thirdImage.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        labelCountAll.frame = CGRect(x: allNotButton.frame.size.width-50, y: 10, width: 40, height: 40)
        
        endedButton.frame = CGRect(x: view.frame.size.width/2+20, y: top+40+todayButton.frame.size.height, width: view.frame.size.width/2-40, height: 100)
        forthTextLabel.frame = CGRect(x: 10, y: 60, width: endedButton.frame.size.width-20, height: 30)
        forthImage.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        
        addNotificationButton.frame = CGRect(x: 10, y: view.frame.size.height-80, width: view.frame.size.width/2-20, height: 40)
        addNewGroupButton.frame = CGRect(x: view.frame.size.width/2+10, y: view.frame.size.height-80, width: view.frame.size.width/2+20, height: 40)
        
        groupTableView.frame = CGRect(x: 20, y: top+todayButton.frame.size.height+allNotButton.frame.size.height+80, width: view.frame.size.width-40, height: 60*count)
        
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateNotification))
        
    }
    //MARK: - @objc targets
    @objc private func didTapCreateNotification(){
        let alert = UIAlertController(title: "Warning!", message: "This function in progress", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fine", style: .default))
        present(alert,animated: true)
                
    }
    
    @objc private func didTapCreateNewGroup(){
        let vc = storyboardInstance.instantiateViewController(withIdentifier: "CreatingGroupViewController") as! CreatingGroupViewController
        let dest = UINavigationController(rootViewController: vc)
        vc.delegate = self
        dest.modalPresentationStyle = .formSheet
        if coreData.groupVaultData.count >= 6 {
            let alert = UIAlertController(title: "Row limit!", message: "Delete one group to add new group", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fine", style: .default))
            present(alert,animated: true)
        } else {
            self.present(dest, animated: true)
        }
    }
    //MARK: - setup funcs and delegates
    
    private func setupView(){
        view.addSubview(todayButton)
        todayButton.addSubview(firstTextLabel)
        todayButton.addSubview(firstImage)
        todayButton.addSubview(labelCountToday)
        
        view.addSubview(tomorrowButton)
        tomorrowButton.addSubview(secondImage)
        tomorrowButton.addSubview(secondTextLabel)
        tomorrowButton.addSubview(labelCountTomorrow)
        
        view.addSubview(allNotButton)
        allNotButton.addSubview(thirdImage)
        allNotButton.addSubview(thirdTextLabel)
        allNotButton.addSubview(labelCountAll)
        
        view.addSubview(endedButton)
        endedButton.addSubview(forthTextLabel)
        endedButton.addSubview(forthImage)
    
        view.addSubview(addNotificationButton)
        view.addSubview(addNewGroupButton)
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
        groupTableView.dragDelegate = self
        groupTableView.dropDelegate = self
      
        
        //delegate from creatingGroupVC to MainPageVC
        let vc = CreatingGroupViewController()
        vc.delegate = self
        
        let list = ListPageViewController()
        list.delegate = self
    }
    

    
    private func setupButtonsTargets(){
        addNotificationButton.addTarget(self, action: #selector(didTapCreateNotification), for: .touchUpInside)
        addNewGroupButton.addTarget(self, action: #selector(didTapCreateNewGroup), for: .touchUpInside)
        }
    
    private func cellCount(count: Int?){
        if count != nil {
            view.addSubview(groupTableView)
        }
    }
    
    private func setDictionaryData(group: [GroupListEntity],list: [NotificationsEntity]){
        coreData.loadDataGroupEntity()
        coreDataNotifications.loadNotificationDataEntity()
        for i in group {
            if let title = i.title, !title.isEmpty {
                dictionaryData[title] = []
            }
        }
        for index in group {
            print(index.title ?? "No title for group")
            for data in list {
                print(data.title ?? "Unexpected found nil")
                
//                var existingItems = dictionaryData[index.title!] ?? [NotificationData]()
//                existingItems.append(NotificationData(Title: data.title!, Subtitle: data.subtitle!))
//                dictionaryData[index.title!] = existingItems
//                print(dictionaryData)
            }
            
        }
    }
}
//MARK: - Delegates methods from CreatingGroupVC
extension MainPageViewController: NewGroupDelegate, ListPageDelegate {
    //list page delegate
    func passNotificationData(data: [NotificationData],key: String,count: Int,date: Date) {
        dictionaryData[key] = data
        DispatchQueue.main.async {
            self.groupTableView.reloadData()
        }
    }
    
    //group page delegate
    func passData(text string: String, color: UIColor, image: UIImage) {
        if cellIndexPath != nil {
            guard let cell = cellIndexPath else { return }
            let data = coreData.groupVaultData[cell]
            coreData.groupVaultData.remove(at: cell)
            coreData.deleteDataGroup(data: data)
            cellIndexPath = nil
        }
        coreData.saveDataGroup(data: CellData.init(Title: string, Image: image, Color: color, Count: 0))
        dictionaryData[string] = []
        groupTableView.frame.size.height += 60.0
        groupTableView.reloadData()
        
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func passIndexPath(cell: MainTableViewCell) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.groupVaultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,for: indexPath) as! MainTableViewCell
        let coredata = coreData.groupVaultData[indexPath.row]
        let titleData = coreData.groupVaultData[indexPath.row].title
        let count = dictionaryData[titleData!]?.count
        cell.configureDataToCell(with: coredata, count: count ?? 0)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
      
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        let vc = ListPageViewController()
        guard let dataTitle = coreData.groupVaultData[indexPath.row].title else { return }
        let navigation = UINavigationController(rootViewController: vc)

        vc.delegate = self
        vc.titleView = dataTitle
        vc.indexPathMainPage = index+1
        vc.listPageData = dictionaryData[dataTitle]!

        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .coverVertical

        present(navigation, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let index = indexPath.row
        let deleteData = coreData.groupVaultData[indexPath.row]
        let deleteEditInstance = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.coreData.groupVaultData.remove(at: index)
            self.coreData.deleteDataGroup(data: deleteData)
            self.coreDataNotifications.deleteAllData()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.frame.size.height -= tableView.rowHeight
        }
        deleteEditInstance.backgroundColor = .systemRed
        deleteEditInstance.image = UIImage(systemName: "trash.fill")
        deleteEditInstance.image?.withTintColor(.systemBackground)
        let action = UISwipeActionsConfiguration(actions: [deleteEditInstance])
        return action
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coredata = coreData.groupVaultData[indexPath.row]
        let color = UIColor.color(withData: coredata.color!)
        cellIndexPath = indexPath.row
        let actionEditInstance = UIContextualAction(style: .normal, title: "") { _, _, _ in
            let vc = CreatingGroupViewController()
            vc.textFieldCustomView.text = coredata.title
            vc.imageViewInCustomView.image = UIImage(data: coredata.image!)?.withTintColor(color!, renderingMode: .alwaysOriginal)
            vc.colorOfItems = color!
            vc.navigationItem.leftBarButtonItem?.isEnabled = false
            vc.delegate = self
            let navigation = UINavigationController(rootViewController: vc)
            navigation.modalPresentationStyle = .formSheet
            self.present(navigation,animated: true)
        }
        actionEditInstance.backgroundColor = .systemBlue
        actionEditInstance.image = UIImage(systemName: "pencil.line")
        actionEditInstance.image?.withTintColor(.systemBackground)
        let actionConfiguration = UISwipeActionsConfiguration(actions: [actionEditInstance])
        return actionConfiguration
    }
    
}

extension MainPageViewController: UITableViewDragDelegate, UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)

    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}
