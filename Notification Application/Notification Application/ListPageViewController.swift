//
//  ListPageViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 14.12.2022.
//

import UIKit
//not used
protocol ListPageDelegate: AnyObject {
    func getTitle(string: String)
}

class ListPageViewController: UIViewController{
    
    
    
    var groupPage: MainPageViewController?

    
    var titleView: String = ""
    private let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    private let tableview: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let createNewPostButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.imageView?.tintColor = .black
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dest = storyboardInstance.instantiateViewController(withIdentifier: "MainPageViewController") as! MainPageViewController
        
        createNewPostButton.addTarget(self, action: #selector(didTapNextView), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapNextView))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(didTapDismiss))
        
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        title = titleView
        
        setupView()
        setupTableView()
        print(titleView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        createNewPostButton.frame = CGRect(x: view.frame.size.width-60, y: view.frame.size.height-80, width: 40, height: 40)
        createNewPostButton.layer.cornerRadius = 0.5 * createNewPostButton.bounds.size.width
    }
    @objc private func didTapDismiss(){
        self.navigationController?.dismiss(animated: true)
        
    }
    
    @objc private func didTapNextView(){
        let vc = UINavigationController(rootViewController: NoteNotificationViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func setupTableView(){
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .systemBackground
    }
    
    private func setupView(){
        view.addSubview(tableview)
        view.addSubview(createNewPostButton)
        
    }
}

extension ListPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
