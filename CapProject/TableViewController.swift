//
//  TableViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/26/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
       
    }

    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
       
        
       print(Teacher.current.listOfCourseKey.count)
        return Teacher.current.listOfCourseKey.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        
        cel.course.text = "bonjour..............................................................."
        return cel
    }
    
}
