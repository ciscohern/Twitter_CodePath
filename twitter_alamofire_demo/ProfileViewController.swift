//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Francisco Hernandez on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    var user = User.current
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.af_setImage(withURL: URL(string: (user?.backgroundPic)!)!)
        profilePicture.af_setImage(withURL: URL(string: (user?.profilePic)!)!)
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = UIColor.clear.cgColor
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        nameLabel.text = user?.name
        screenNameLabel.text = user?.screenName
        taglineLabel.text = user?.description
        tweetCountLabel.text = String(user!.tweetsCount)
        followersCountLabel.text = "\(user?.followersCount ?? -1)"
        followingCountLabel.text = "\(user?.followingCount ?? -1)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
