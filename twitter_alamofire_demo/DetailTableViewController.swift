//
//  DetailTableViewController.swift
//  twitter_alamofire_demo
//
//  Created by Francisco Hernandez on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicImageView.af_setImage(withURL: URL(string: tweet.user.profilePic)!)
        profilePicImageView.layer.borderWidth = 1
        profilePicImageView.layer.borderColor = UIColor.clear.cgColor
        profilePicImageView.layer.masksToBounds = false
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.height/2
        profilePicImageView.clipsToBounds = true
        if(tweet.favorited == true){
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: [])
        }
        else{
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: [])
        }
        print(tweet.text)
        tweetLabel.text = tweet.text
        print(tweet.user.name)
        nameLabel.text = tweet.user.name
        usernameLabel.text = ("@" + tweet.user.screenName!)  as String?
        tweetCount.text = String(tweet.retweetCount)
        if(tweet.favoriteCount != nil){
            let fc = tweet.favoriteCount!
            favoriteCount.text = String(fc)
        }
        else{
            favoriteCount.text = ""
        }
        if(tweet.retweeted == true){
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: [])
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: [])
        }
        dateLabel.text = tweet.createdAtString
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    @IBAction func retweetButtonTapped(_ sender: Any) {
        print(tweet.retweeted)
        if(tweet.retweeted == true){
            tweet.retweeted = false
            tweet.retweetCount -= 1
            tweetCount.text = String(tweet.retweetCount)
            print(tweet.retweetCount)
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: [])
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweet the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else{
            tweet.retweeted = true
            tweet.retweetCount += 1
            tweetCount.text = String(tweet.retweetCount)
            print(tweet.retweetCount)
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: [])
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweet the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        if(tweet.favorited == true){
            print("Inside unfavoriting")
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: [])
        }
        else{
            print("Inside favoriting")
            tweet.favorited = true
            tweet.favoriteCount! += 1
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: [])
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        if(tweet.favoriteCount != nil){
            let fc = tweet.favoriteCount!
            var favStr = String(fc)
            print(fc/1000)
            if(fc/1000 >= 1 ){
                let favDec = String(fc/1000)
                let index = favDec.index(favDec.startIndex, offsetBy: 2)
                let FinalSubstr = favDec[..<index]
                favStr = FinalSubstr+"k"
                print(favStr)
            }
            favoriteCount.text = favStr
        }
        else{
            favoriteCount.text = ""
        }
    }
    @IBAction func replyButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
