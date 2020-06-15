//
//  ViewController.swift
//  Next-flix
//
//  Created by John Kim on 6/12/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import UIKit

class ComingController: UITableViewController {

    var exampleArr = ["Testing1","Testing2","Testing3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleArr.count
    }


}

