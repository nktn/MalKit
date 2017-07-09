//
//  ViewController.swift
//  Sample
//
//  Created by nktn on 2017/07/09.
//  Copyright © 2017年 nktn. All rights reserved.
//

import UIKit
import MalKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,XMLParserDelegate {
    var responseArray:NSArray = []
    // WARN: "You need modify user_id and passwd."
    let m = MalKit.init(user_id: "", passwd: "")
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func add(_ sender: Any) {
        
        _ = self.m.addAnime("20",query: "<entry><status>6</status></entry>", completionHandler: { (result, res, err) in
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
        _ = self.m.searchAnime("naruto", completionHandler: { (items, res, err) in
            if err == nil {
                let parser = XMLParser.init(data: items!)
                parser.delegate = self;
                parser.parse()
            }
            
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //TODO: cell
        return cell
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("start_xml_parse")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("start_tag:" + elementName)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("element:" + string)
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("end_tag:" + elementName)
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("end_xml_parse")
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("error:" + parseError.localizedDescription)
    }
}

