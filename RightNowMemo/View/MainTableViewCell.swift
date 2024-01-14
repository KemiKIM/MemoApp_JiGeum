//
//  MainTableViewCell.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/10/14.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    
    
    // MARK: [변수 선언]
    let mainLabel = UILabel()
    let subLabel = UILabel()
    
    
    
    
    
    // MARK: [Override]
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .black
        
        addView()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    
    
    
    
    
    
    // MARK: [Add View]
    func addView() {
        self.addSubview(mainLabel)
        self.addSubview(subLabel)
    }
    
    
    
    // MARK: [Layout]
    func layout() {
        layoutMainLabel()
        layoutSubLabel()
    }
    
    
    
    func layoutMainLabel() {
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mainLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.mainLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
        ])
    }
    
    
    func layoutSubLabel() {
        self.subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.subLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.subLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.subLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    
}
