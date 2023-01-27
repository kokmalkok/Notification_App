//
//  ListPageViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 14.12.2022.
//

import UIKit

protocol ListPageDelegate: AnyObject {
    func passNotificationData(data: [NotificationData],key: String,count: Int,date: Date)
}

class ListPageViewController: UIViewController, UINavigationControllerDelegate {

    private let coreData = NotificationsDataStack.instance
    
    weak var delegate: ListPageDelegate?
    
    private let notificationDate = Date()
    
    var indexPathMainPage: Int? = nil
    var indexCount = 0
    private var indexCell: Int? = nil
    
    
    
    var listPageData: [NotificationData] = []

    var titleView: String = ""
    private let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    private let tableview: UITableView = {
       let table = UITableView()
        table.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return table
    }()
    
    private let addNotificationButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName:"plus"), for: .normal)
        button.currentImage?.withTintColor(.systemBackground)
        button.setTitle(" Notification", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = NoteNotificationViewController()
        vc.delegate = self
        let secVC = SetReminderViewController()
        secVC.delegate = self

        setupNavigationController()
        setupView()
        setupTableView()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        addNotificationButton.frame = CGRect(x: 10, y: view.frame.size.height-80, width: view.frame.size.width/2-20, height: 40)
        
    }
    @objc private func didTapDismiss(){
        delegate?.passNotificationData(data: self.listPageData,key: self.titleView,count: self.listPageData.count,date: self.notificationDate)
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

    @objc private func didTapAccessoryType(){
        let reminder = SetReminderViewController()
        reminder.delegate = self
        reminder.isModalInPresentation = true
        reminder.modalPresentationStyle = .pageSheet
        reminder.sheetPresentationController?.detents = [.medium(),.large()]
        reminder.sheetPresentationController?.prefersGrabberVisible = true
        reminder.sheetPresentationController?.preferredCornerRadius = 8.0
        reminder.sheetPresentationController?.dismissalTransitionWillBegin()
        present(reminder, animated: true)
    }
    
    @objc private func didTapNextView(){
        let vc = NoteNotificationViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    //MARK: - Setups methods

    
    private func setupNavigationController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapNextView))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(didTapDismiss))
    }
    
    private func setupTableView(){
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .systemBackground
        tableview.dropDelegate = self
        tableview.dragDelegate = self
    }
    
    private func setupView(){
        view.addSubview(tableview)
        view.addSubview(addNotificationButton)
        title = titleView
        view.backgroundColor = .secondarySystemBackground
        //targets
        addNotificationButton.addTarget(self, action: #selector(didTapNextView), for: .touchUpInside)
    }
}
//MARK: - Delegate method
extension ListPageViewController: SetReminderDelegate, NewNotificationCreated {
    //date reminder protocol

    func passData(notificationDate: Date) {
        let data = listPageData[indexPathMainPage!]
        let dateParameter = notificationDate
        
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "\(data.Title)\n\(data.Subtitle)"
        content.sound = .defaultRingtone
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateParameter), repeats: false)//можно передать параметр повтора да или нет
        
        let request = UNNotificationRequest(identifier: data.Title, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("Error notification")
            }
        }
        
    }
    
    //creating cell data protocol
    func passData(mainLabel: String, detailLabel: String, arrayIndex: Int) {
        if indexCell != nil {
            guard let cell = indexCell else { return }
            listPageData.remove(at: cell)
            indexCell = nil
        }
        listPageData.append(NotificationData(Title: mainLabel, Subtitle:detailLabel))
        self.tableview.reloadData()
    }
}

extension ListPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPageData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let data = listPageData[indexPath.row]
        cell.configureDataToCell(with: data)
        cell.accessoryType = .detailButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        indexPathMainPage = indexPath.row
        let reminder = SetReminderViewController()
        reminder.delegate = self
        reminder.isModalInPresentation = true
        reminder.modalPresentationStyle = .pageSheet
        reminder.sheetPresentationController?.detents = [.medium(),.large()]
        reminder.sheetPresentationController?.prefersGrabberVisible = true
        reminder.sheetPresentationController?.preferredCornerRadius = 8.0
        reminder.sheetPresentationController?.dismissalTransitionWillBegin()
        present(reminder, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        indexCell = indexPath.row
        let index = indexPath.row
        let vc = NoteNotificationViewController()
        let data = listPageData[index]

        let navigation = UINavigationController(rootViewController: vc)
        
        vc.delegate = self
        vc.titleEdit = data.Title
        vc.subtitleEdit = data.Subtitle
        vc.arrayIndex = index
        
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .coverVertical
        
        present(navigation, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        indexCell = indexPath.row
        let data = listPageData[indexPath.row]
        let index = indexPath.row
        let actionEditInstance = UIContextualAction(style: .normal, title: "") { _, _, _ in
            let vc = NoteNotificationViewController()
            
            let navigation = UINavigationController(rootViewController: vc)
            
            vc.delegate = self
            vc.titleEdit = data.Title
            vc.subtitleEdit = data.Subtitle
            vc.arrayIndex = index
            
            navigation.modalPresentationStyle = .fullScreen
            navigation.modalTransitionStyle = .coverVertical
            
            self.present(navigation, animated: true)
        }
        actionEditInstance.backgroundColor = .systemBlue
        actionEditInstance.image = UIImage(systemName: "pencil.line")
        actionEditInstance.image?.withTintColor(.systemBackground)
        let action = UISwipeActionsConfiguration(actions: [actionEditInstance])
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let index = indexPath.row
        let data = listPageData[indexPath.row]
        let deleteEditInstance = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.listPageData.remove(at: index)
            let center = UNUserNotificationCenter.current()
            center.removeDeliveredNotifications(withIdentifiers: [data.Title])
            center.removePendingNotificationRequests(withIdentifiers: [data.Title])
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        deleteEditInstance.backgroundColor = .systemRed
        deleteEditInstance.image = UIImage(systemName: "trash.fill")
        deleteEditInstance.image?.withTintColor(.systemBackground)
        let action = UISwipeActionsConfiguration(actions: [deleteEditInstance])
        return action
    }
    
}

extension ListPageViewController: UITableViewDragDelegate, UITableViewDropDelegate {

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
