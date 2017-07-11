//
//  ViewController.swift
//  Sample
//
//  Created by nktn on 2017/07/09.
//  Copyright © 2017年 nktn. All rights reserved.
//

import UIKit
import SWXMLHash

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var responseArray:NSArray = []
    var xml: XMLIndexer? = nil
    @IBOutlet weak var tableView: UITableView!
    @IBAction func add(_ sender: Any) {
        _ = MalKit.sharedInstance.addAnime("20",query: "<entry><status>6</status></entry>", completionHandler: { (result, res, err) in
            if err == nil {
                var str:String = "NG"
                if result == true  {
                 str = "OK"
                }
                let alertController = UIAlertController(title: "response",message: str, preferredStyle: UIAlertControllerStyle.alert)
                let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alertController.addAction(cancelButton)
                self.present(alertController,animated: true,completion: nil)
            }
        })
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        _ = MalKit.sharedInstance.searchAnime("naruto", completionHandler: { (items, res, err) in
            if err == nil {
                if items != nil{
                    DispatchQueue.main.async(execute: {
                        self.xml = SWXMLHash.parse(items!)
                        self.tableView.reloadData()
                    })
                }
            }
            
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.xml?["anime"]["entry"].all.count != nil {
            return (self.xml?["anime"]["entry"].all.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.xml?["anime"]["entry"][indexPath.row]["title"].element?.text ?? ""

        return cell
    }
    
}

