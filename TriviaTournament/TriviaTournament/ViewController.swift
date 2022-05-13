//
//  ViewController.swift
//  TriviaTournament
//
//  Created by Vy Nghiem on 12/01/21.
//
//  Disclaimer:
//  This App is developed as an educational project. Certain materials are included under the fair use exemption of the U.S. Copyright Law and have been prepared according to the multimedia fair use guidelines and are restricted from further use.
//
//  Images: answer frame and tea images created by Vy Nghiem
//  Sound: BBC Sound (https://sound-effects.bbcrewind.co.uk)

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var imgQuestionImage: UIImageView!
    
    // create an object of the AV Player
    var mySound:AVAudioPlayer!
    
    @IBOutlet weak var imgAnswerFrame: UIImageView!
    
    @IBOutlet weak var lblAnswer: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    
    // create an array of Question objects
    var QuestionObjectArray = [Question]()
    var passedQuestion:Question = Question()
    var randomGlobalObject:Question = Question()
    
    func setLabels(){
        let randomQ = passedQuestion
        
        randomGlobalObject = randomQ
        lblQuestion.text = randomQ.QuestionContent
        lblAnswer.text = randomQ.QuestionID + "\n" + randomQ.QuestionAnswer
        
        mySound.play()
    }
    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        lblQuestion.alpha = 1.0
        lblAnswer.alpha = 1.0
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // hide the question, the answer and the image on shake motion
        UIView.animate(withDuration:3.0, animations : {
            self.lblQuestion.alpha = 0.0
            self.lblAnswer.alpha = 0.0
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mySound = try? AVAudioPlayer(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource: "07070114", ofType: "wav")!))
        setLabels()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSubDetail" {
            let destController = segue.destination as! DetailViewController
            // pass the Question object received to the next view via the segue by using "self"
            destController.passedQuestion = self.passedQuestion
        }
    }

}
