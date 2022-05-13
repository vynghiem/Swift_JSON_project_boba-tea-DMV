//
//  MasterViewController.swift
//  TriviaTournament
//
//  Created by Vy Nghiem on 12/01/21.
//

import Foundation
import UIKit

class MasterViewController: UITableViewController {
    
    // create an array of Question objects
    var QuestionObjectArray = [Question]()
    
    //utility function that takes an Image URL and returns a UIImage object
    func convertToImage(imgURL:String) ->UIImage {
        // Reach out to the URL and download bytes of data.
        // convert string t a URL type
        let imgURL2 = URL(string:imgURL)!
        // call the end point and receive the Bytes
        let imgData  = try? Data(contentsOf: imgURL2)
        print(imgData ?? "Error. Image does not exist at URL \(imgURL)")
        // convert bytes of data to image type
        let img = UIImage(data: imgData!)
        // return the UIImage
        return img!
    }
    
    
    func populateQuestionFromJSON(){
        // get the End point
        let endPoint = "https://raw.githubusercontent.com/vynghiem/Swift_JSONproject_IT315/Swift_JSONproject_IT315/TriviaTournament_JSON.json"
        let JSONurl = URL(string: endPoint)!

        // get the data
        let responseData = try? Data(contentsOf: JSONurl)
        // display error msg if there is no JSON data
        print(responseData ?? "Error. No data to print. responseData is nil")
        // if no issue then print the JSON Data
        print(responseData)

        // convert/serialize JSON to Dictionaries
        // take the JSON objects/array and convert them into Question objects
        if(responseData != nil){
            let dictionary:NSDictionary = (try!
                JSONSerialization.jsonObject(with: responseData!, options:
                JSONSerialization.ReadingOptions.mutableContainers)) as!NSDictionary
            
            // print for debugging purpose
            print(dictionary)
            
            let QuestionDictionary =  dictionary["Question"]! as! [[String:AnyObject]]

            for index in 0...QuestionDictionary.count - 1 {
                let singleQuestion = QuestionDictionary[index]
                let ques = Question()
                ques.QuestionID = singleQuestion["QuestionID"]! as! String
                ques.QuestionTopic = singleQuestion["QuestionTopic"]! as! String
                ques.QuestionContent = singleQuestion["QuestionContent"]! as! String
                ques.QuestionAnswer = singleQuestion["QuestionAnswer"]! as! String
                ques.QuestionLat = singleQuestion["QuestionLat"]! as! Double
                ques.QuestionLon = singleQuestion["QuestionLon"]! as! Double
                ques.QuestionImage = singleQuestion["QuestionImage"]! as! String
                ques.QuestionSite = singleQuestion["QuestionSite"]! as! String
                QuestionObjectArray.append(ques)
            }
        }
    }
    
    
    // whenever create a UIViewController, make a habit to start with this first
    override func viewDidLoad() {
        super.viewDidLoad()
        populateQuestionFromJSON()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            // find destination controller
            let destController = segue.destination as! ViewController
            
            // find the selected table row (index)
            let indexPath = tableView.indexPathForSelectedRow
            
            // find the selected object index in the array and reterive the object from the array
            let questionObject = QuestionObjectArray[indexPath!.row]
            
            // pass the selected object to the destination controller
            destController.passedQuestion = questionObject
        }
    }
    
    
    // when creating a table view, we can establish many sections and categories (multiple arrays and multiple indexes)
    override func numberOfSections(in tableView: UITableView) -> Int {
        // here we return 1 for 1 section
        return 1
    }
    
    
    // numberOfRowsInSection: declare the number of rows in section
    // can be used for cellForRowAt code later
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return here the total number of objects in the array
        return QuestionObjectArray.count
    }
    
    
    // this function set up the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // pull out the first object (in the Question objects array) based on the index row
        let questionObject = QuestionObjectArray[indexPath.row]
        
        // attributes list
        let questionID = questionObject.QuestionID
        let questionTopic = questionObject.QuestionTopic
        let questionImageURL = questionObject.QuestionImage
     
        // move objects in the array one by one to the cell/row
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellName", for: indexPath)
        
        // display Question object attributes on each row/cell
        // we can format the display style here
        cell.textLabel!.text = questionID
        cell.detailTextLabel!.text = questionTopic
        
        let img = convertToImage(imgURL: questionImageURL)

        cell.imageView?.image = img
        cell.imageView!.layer.cornerRadius = 10
        cell.imageView!.clipsToBounds = false
        cell.imageView!.layer.borderWidth = 2
        cell.imageView!.layer.borderColor = UIColor.lightGray.cgColor

        self.tableView.rowHeight = 70.0
        
        return cell
    }
}
