//
//  SaveFilesController.swift
//  ARKitMockUp
//
//  Created by Dhiraj Laddha on 22/04/19.
//  Copyright © 2019 Dhiraj Laddha. All rights reserved.
//

import UIKit

class SaveFilesController: UIViewController {

    @IBOutlet var saveTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialViewSetUp()
    }
    
    func initialViewSetUp(){
        registerTableCell()
    }
    
    func registerTableCell(){
        saveTableView.register(UINib.init(nibName: "SaveFileCell", bundle: nil), forCellReuseIdentifier: "saveFile")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: -- UITableViewDataSource, UITableViewDelegate
extension SaveFilesController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveFile", for: indexPath) as! SaveFileCell
        
        return cell
    }
    
    
}
