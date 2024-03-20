//
//  ResultsPage.swift
//  15Puzzle_1_1
//
//  Created by Abdurazzoqov Islombek on 07/06/23.
//

import UIKit

class ResultsPage: UIViewController {
    
    let tableView = UITableView()
    var recordsArr = [Record]()
    var recordsTitleLabel = UILabel()
    let deleteAllBtn = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backColor
        
        recordsTitleLabelDesign()
        tableView.backgroundColor = .clear
        tableView.register(TableCellModel.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(recordsTitleLabel.snp.bottom)
        }
        deleteBtnDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func recordsTitleLabelDesign() {
        recordsTitleLabel = .textPropertiesBackColor(.clear, .white, .center)
        recordsTitleLabel.text = "Results"
        recordsTitleLabel.font = .systemFont(ofSize: 0.07 * wd, weight: .semibold)
        view.addSubview(recordsTitleLabel)
        
        recordsTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(0.8 * wd)
            make.height.equalTo(0.2 * wd)
            make.top.equalTo(20)
        }
    }
    
    func deleteBtnDesign() {
        deleteAllBtn.backgroundColor = .clear
        deleteAllBtn.setTitle("Delete all", for: .normal)
        deleteAllBtn.setTitleColor(.gray, for: .normal)
        deleteAllBtn.titleLabel?.font = UIFont(name: "Futura", size: 0.045*wd)
        deleteAllBtn.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside)
        view.addSubview(deleteAllBtn)
        
        deleteAllBtn.snp.makeConstraints { make in
            make.right.equalTo(-mg)
            make.width.equalTo(0.22 * wd)
            make.top.equalTo(mg)
            make.height.equalTo(0.08 * wd)
        }
    }
    
    @objc func deleteBtnClick() {
        CoreDataFunc().deleteAll(recordsArr)
        dismiss(animated: true)
    }
}

extension ResultsPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recordsArr = CoreDataFunc().getAllItem()
        if recordsArr.count == 0 {
            isEmptyTitle()
        }
        return recordsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCellModel
        let record = recordsArr[indexPath.row]
        cell.initData(record)
        return cell
    }
    
    func isEmptyTitle() {
        var emptyTitle = UILabel()
        emptyTitle = .textPropertiesBackColor(.clear, .white, .center)
        emptyTitle.text = "Results not specified"
        emptyTitle.font = UIFont(name: "Futura", size: 0.05*wd)
        view.addSubview(emptyTitle)
        
        emptyTitle.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(0.1*hg)
        }
    }
}
