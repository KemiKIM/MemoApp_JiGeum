//
//  TestViewController.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/09/27.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    

    private lazy var tableView = UITableView()
    
    let temporaryList = ["1","2","3"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.backgroundColor = .systemBackground
        
        self.configureTableView()
        attribute()
        
    }
    


    
    
    // 4
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }
    
    func attribute() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temporaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = temporaryList[indexPath.row]
        
        return cell
    }

}
