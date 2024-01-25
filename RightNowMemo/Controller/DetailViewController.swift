//
//  DetailViewController.swift
//  RightNowMemo
//
//  Created by 김성호 on 2022/10/14.
//

import UIKit

class DetailViewController: UIViewController {
    let dataManager = CoreDataManager.shared
    var detailVCData: MemoData?
    
    
    
    
    // MARK: [변수 선언] [0]: Top
    private lazy var titleView = UIView()
    
    
    
    
    
    // MARK: [변수 선언] [1]: Table View
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DateCell.self, forCellReuseIdentifier: DateCell.identifier)
        tableView.register(MemoContextCell.self, forCellReuseIdentifier: MemoContextCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        return tableView
    }()
    
    
    
    
    
    // MARK: [변수 선언] [2]: Right Bottom
    private lazy var rightBottomButton: UIButton = {
        let rightBottom = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let rBottomImg = UIImage(systemName: "rays", withConfiguration: imageConfig)

        rightBottom.setImage(rBottomImg, for: .normal)
        
        rightBottom.tintColor = .white

        rightBottom.addTarget(self, action: #selector(presentTapped(sender:)), for: .touchUpInside)
        
        return rightBottom
    }()
    
    
    
    private lazy var copyButton: UIButton = {
        let copy = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold)
        let copyImg = UIImage(systemName: "rectangle.portrait.on.rectangle.portrait", withConfiguration: imageConfig)
        
        copy.setImage(copyImg, for: .normal)
        
        copy.tintColor = .white
        
        copy.addTarget(self, action: #selector(copyButtonTapped(_sender:)), for: .touchUpInside)
        
        return copy
    }()

    
    
    
    
    
    
    
    
    
    
    // MARK: [Override]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "RIDIBatang", size: 17)!], for: UIControl.State.normal)
        

        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Navigationbar
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       
        layout()
        
        print("DetailViewController - viewDidLoad")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("DetailViewController - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("DetailViewController - viewDidAppear")
    }

    
    
    
    
    // MARK: [Action]
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func sharedButtonTapped() {
        guard let data = detailVCData?.memoText else { return }
        
        let vc = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc fileprivate func presentTapped(sender: UIButton) {
        self.animateView(sender)
        moveView()
    }
    
    
    
    fileprivate func animateView(_ viewToAnimate: UIView) {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        
    }
    
    
    private func moveView() {
        let vc = SettingDetailViewController()
        
        vc.settingDetailVCDelegate = self
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
        
        self.rightBottomButton.isHidden = true
        self.copyButton.isHidden = true
    
    }
    
    
    @objc private func copyButtonTapped(_sender: UIButton) {
        guard let data = detailVCData?.memoText else { return }
        UIPasteboard.general.string = data
        showToast(message: "복사되었어요!", font: UIFont.systemFont(ofSize: 18))
        
    }
    


  
    
    
    
    
    
// MARK: [Class End]
        
}

// MARK: [Class End]









// MARK: [ (S) Protocol]
extension DetailViewController: moveToDetail {
    
    func deleteMethod() { self.deleteMemo() }
    func editMethod()   { self.editMemo()   }
    func buttonFalse() {
        self.rightBottomButton.isHidden = false
        self.copyButton.isHidden = false
    }

    
    @objc private func deleteMemo() {
        
        if let delete = self.detailVCData {
            dataManager.deleteData(data: delete) {
                print("delete complete")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
   

    
    @objc func editMemo() {
        let vc = StartViewController()
        vc.editTarget = detailVCData
        self.navigationController?.pushViewController(vc, animated: false)
    }
}





// MARK: [TableView - DataSource]
extension DetailViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ridi = UIFont(name: "RIDIBatang", size: 18)
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.identifier, for: indexPath) as! DateCell
            cell.selectionStyle = .none
            
            cell.label.text = detailVCData?.detailDateString
            cell.label.textColor = .lightText
            cell.label.font = ridi
            cell.label.textAlignment = .center
            
            return cell
            
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MemoContextCell.identifier, for: indexPath) as! MemoContextCell
            cell.selectionStyle = .none
            
            cell.label.text = detailVCData?.memoText
            cell.label.textColor = .white
            cell.label.font = ridi
            cell.label.numberOfLines = 0
            
            return cell
           
            
        default:
            fatalError()
        }
    }
    
}


// MARK: [TableView - Delegate]
extension DetailViewController: UITableViewDelegate {
    
}













// MARK: [Layout] + [Back.Col]
extension DetailViewController {

    private func layout() {
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)
        self.view.backgroundColor = .black

        
        naviCustom()
        //
        layoutTableView()
        //
        layoutRightBottomButton()
        layoutCopyButton()
    }
    
    
    
    
    private func naviCustom() {
        // self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "background6")!)
        self.navigationController?.navigationBar.barTintColor = .black
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white

        
        let arrowImg = UIImage(named: "custom-arrow-left")
        let leftImg = arrowImg?.resizeImage(size: CGSize(width: 20, height: 40))
        let backbutton = UIBarButtonItem(image: leftImg, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backbutton
        
        
        let sharedButton = UIBarButtonItem(title: "공유", style: .plain, target: self, action: #selector(sharedButtonTapped))
        self.navigationItem.rightBarButtonItem = sharedButton
        self.navigationItem.rightBarButtonItem?.tintColor = .systemGreen
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
    
    
    
    
    private func layoutTableView() {
        self.view.addSubview(self.tableView)

        // self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background6")!)
        self.tableView.backgroundColor = .black
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func layoutRightBottomButton() {
        self.view.addSubview(rightBottomButton)
        
        self.rightBottomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.rightBottomButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.rightBottomButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    private func layoutCopyButton() {
        self.view.addSubview(self.copyButton)
        
        self.copyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.copyButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.copyButton.bottomAnchor.constraint(equalTo: self.rightBottomButton.topAnchor, constant: -20)
        ])
    }
    
    
}






extension UIImage {
    
    func resizeImage(size: CGSize) -> UIImage {
        let originalSize = self.size
        let ratio: CGFloat = {
            return originalSize.width > originalSize.height ? 1 / (size.width / originalSize.width) :
            1/(size.height / originalSize.height)
        }()
        
        return UIImage(cgImage: self.cgImage!, scale: self.scale * ratio, orientation: self.imageOrientation)
    }
    
}
