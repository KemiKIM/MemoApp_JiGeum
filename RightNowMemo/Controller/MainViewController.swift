//
//  MainViewController.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/09/22.
///

import UIKit


// MARK: [ (D) Protocol ]
protocol moveToStart {
    func firstSetting()
}




class MainViewController: UIViewController {
    let dataManager = CoreDataManager.shared
    var mainVCDelegate: moveToStart?
    let ridi = UIFont(name: "Cafe24SsurroundAir", size: 15)
    let cafe24Ssurround = UIFont(name: "Cafe24Ssurround", size: 25)
    
    
    // MARK: [변수 선언] [0] : Title
    private lazy var titleView = UIView()
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        
        title.font = cafe24Ssurround
        title.text = "지금 당겨서 메모"
        title.textColor = .white
        
        return title
    }()
    
    
    // MARK: [변수 선언] [1] : Sub Title
    private lazy var titleSubView1: UIView = {
        let sub1 = UIView()
        
        sub1.settingTopViewLine()
        
        return sub1
    }()
    
    private lazy var titleSubView2: UIView = {
        let sub2 = UIView()
        
        sub2.settingTopViewLine()
        
        return sub2
    }()
    
    private lazy var titleSubView3: UIView = {
        let sub3 = UIView()
        
        sub3.settingTopViewLine()
        
        return sub3
    }()
    
    
    // MARK: [변수 선언] [2] : Refresh Image
    let refreshControl = UIRefreshControl()
    
    private lazy var refreshImgBackView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    
    private lazy var refreshImg: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "arrow.down"))
        
        img.tintColor = .black
        img.clipsToBounds = true
        
        return img
    }()
    
    
    
    
    // MARK: [변수 선언] [3] : Table View
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)

        tableview.rowHeight = 60
        tableview.separatorStyle = .none
        
        return tableview
    }()
    
    
    
    


    
    
    
    
    // MARK: [Override]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customRefresh()
        self.tableView.refreshControl = refreshControl
        
        layout()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    
    
    
    
    // MARK: [Action] : [Refresh]
    private func customRefresh() {
        refreshImgBackView.addSubview(self.refreshImg)
        refreshControl.addSubview(self.refreshImgBackView)
        
        
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        refreshControl.attributedTitle = NSMutableAttributedString(string: "당겨서 메모 추가하기", attributes: attributes)
        
        
        
        mainVCDelegate?.firstSetting()
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh(refresh:)), for: .valueChanged)
    }


    
    @objc func pullToRefresh(refresh: UIRefreshControl) {
        
        refresh.endRefreshing()
        
        self.tableView.reloadData()
        
        let vc = StartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
// MARK: [Class End]
                
}

// MARK: [Class End]











// MARK: [TableView - DataSource]
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getDataFromCoreData().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        let target = dataManager.getDataFromCoreData()[indexPath.row]
        
        
    
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        cell.mainLabel.text = target.memoText
        cell.mainLabel.textColor = .white
        cell.mainLabel.font = ridi
        
        cell.subLabel.text = target.dateString
        cell.subLabel.textColor = .white
        cell.subLabel.font = ridi
        
        
        cell.mainLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        cell.subLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        
        return cell
    }
   
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        vc.detailVCData = dataManager.getDataFromCoreData()[indexPath.row]
       
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            

            let target = dataManager.getDataFromCoreData()[indexPath.row]
            CoreDataManager.shared.deleteData(data: target) {
                print("delete complete")
                
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    
}


// MARK: [TableView - Delegate]
extension MainViewController:  UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        var refreshBounds = refreshControl.bounds
        let pullDistance = CGFloat(max(0.0, -refreshControl.frame.origin.y))
        let midX: CGFloat = tableView.frame.size.width / 2.0
        
        let loadingImgHeight = refreshImg.bounds.size.height
        let loadingImgHeightHalf = loadingImgHeight / 2.0
        
        let loadingImgWidth = refreshImg.bounds.size.width
        let loadingImgWidthHalf = loadingImgWidth / 2.0
        
        let loadingImgY = pullDistance / 2.0 - loadingImgHeightHalf
        let loadingImgX = midX - loadingImgWidthHalf
    
        var loadingImgFrame = refreshImg.frame
        loadingImgFrame.origin.x = loadingImgX
        loadingImgFrame.origin.y = loadingImgY
    
        refreshImg.frame = loadingImgFrame
        
        refreshBounds.size.height = pullDistance
    }
    
}












// MARK: [Layout] + [Back.Col]
extension MainViewController {
    private func layout() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)
        
        self.layoutTitleView()
        self.layoutTitleLabel()
        //
        self.layoutTitleSubView1()
        self.layoutTitleSubView2()
        self.layoutTitleSubView3()
        //
        self.layoutTableView()
 
        
    }
    
    
    
  
    private func layoutTitleView() {
        self.view.addSubview(self.titleView)
        
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.titleView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.titleView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.titleView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    
    private func layoutTitleLabel() {
        self.titleView.addSubview(self.titleLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.titleView.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor)
        ])
    }
    
    
    private func layoutTitleSubView1() {
        self.view.addSubview(self.titleSubView1)
        
        self.titleSubView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleSubView1.topAnchor.constraint(equalTo: self.titleView.safeAreaLayoutGuide.bottomAnchor),
            self.titleSubView1.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            self.titleSubView1.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            self.titleSubView1.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    
    
    private func layoutTitleSubView2() {
        self.view.addSubview(self.titleSubView2)
        
        self.titleSubView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleSubView2.topAnchor.constraint(equalTo: self.titleSubView1.safeAreaLayoutGuide.bottomAnchor, constant: 2),
            self.titleSubView2.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            self.titleSubView2.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            self.titleSubView2.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    
    
    private func layoutTitleSubView3() {
        self.view.addSubview(self.titleSubView3)

        self.titleSubView3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleSubView3.topAnchor.constraint(equalTo: self.titleSubView2.safeAreaLayoutGuide.bottomAnchor, constant: 2),
            self.titleSubView3.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            self.titleSubView3.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            self.titleSubView3.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    
    
    
    private func layoutTableView() {
        self.view.addSubview(self.tableView)
        
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.titleSubView3.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
}


// MARK: [Extension UIView]
extension UIView {
    func settingTopViewLine() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
    }
}
