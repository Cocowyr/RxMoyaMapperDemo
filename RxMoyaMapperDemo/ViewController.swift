//
//  ViewController.swift
//  RxMoyaMapperDemo
//
//  Created by jkyeo on 16/6/29.
//  Copyright © 2016年 jkyeo. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var dataSets = [BoxofficeModel]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func buttonAction(sender: UIButton) {
        apiProvider.request(ApiService.GetRank(area: "CN"))
            .mapResponseToObjArray(BoxofficeModel)
            .subscribe(
                onNext: { items in
                    self.dataSets = items
                    self.tableView.reloadData()
                },
                onError: { error in
                    print(error)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSets.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("rankCell") as? RankTableViewCell
        if nil == cell {
            cell = RankTableViewCell(style: .Default, reuseIdentifier: "rankCell")
        }
        
        cell?.nameLabel.text = dataSets[indexPath.row].name
        cell?.rankLabel.text = "\(dataSets[indexPath.row].tboxoffice!) 万元"
        
        return cell!
    }
    
}

