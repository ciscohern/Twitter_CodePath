//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Francisco Hernandez on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import UITextView_Placeholder

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}
class ComposeViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var composeTextView: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    weak var delegate: ComposeViewControllerDelegate?
//    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.placeholder = "What's happening?"
        composeTextView.delegate = self
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if let error = error {
                print("Failed to attain user info")
            } else if let user = user {
                self.userProfilePic.af_setImage(withURL: URL(string: user.profilePic)!)
            }
        })
    }

    @IBAction func xButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetTapped(_ sender: Any) {
//        composeTextView.text
        APIManager.shared.composeTweet(with: composeTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Checks the proposed new text character count
        // Allow or disallow the new text
        
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        charCountLabel.text = String(characterLimit - newText.count)
        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
