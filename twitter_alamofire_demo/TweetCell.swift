//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Francisco Hernanedez on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//


import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoritedCount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            profilePic.af_setImage(withURL: URL(string: tweet.user.profilePic)!)
            profilePic.layer.borderWidth = 1
            profilePic.layer.borderColor = UIColor.clear.cgColor
            profilePic.layer.masksToBounds = false
            profilePic.layer.cornerRadius = profilePic.frame.height/2
            profilePic.clipsToBounds = true
            if(tweet.favorited == true){
                favButton.setImage(UIImage(named: "favor-icon-red.png"), for: [])
            }
            else{
                favButton.setImage(UIImage(named: "favor-icon.png"), for: [])
            }
            tweetTextLabel.text = tweet.text
            NameLabel.text = tweet.user.name
            screenName.text = ("@" + tweet.user.screenName!)  as String?
            retweetCount.text = String(tweet.retweetCount)
            if(tweet.favoriteCount != nil){
                let fc = tweet.favoriteCount!
                favoritedCount.text = String(fc)
            }
            else{
                favoritedCount.text = ""
            }
            if(tweet.retweeted == true){
                rtButton.setImage(UIImage(named: "retweet-icon-green.png"), for: [])
            }
            else{
                rtButton.setImage(UIImage(named: "retweet-icon.png"), for: [])
            }
            dateLabel.text = tweet.createdAtString

        }
    }
    
    @IBAction func replyButtonTapped(_ sender: Any) {
    }
    @IBAction func retweetButtonTapped(_ sender: Any) {
        print(tweet.retweeted)
        if(tweet.retweeted == true){
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweetCount.text = String(tweet.retweetCount)
            print(tweet.retweetCount)
            rtButton.setImage(UIImage(named: "retweet-icon.png"), for: [])
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
            retweetCount.text = String(tweet.retweetCount)
            print(tweet.retweetCount)
            rtButton.setImage(UIImage(named: "retweet-icon-green.png"), for: [])
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweet the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    @IBAction func favoritedButtonTapped(_ sender: Any) {
        // TODO: Update the local tweet model
        // TODO: Update cell UI
        print(tweet.favorited)
        if(tweet.favorited == true){
            print("Inside unfavoriting")
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            print(tweet.favoriteCount)
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            favButton.setImage(UIImage(named: "favor-icon.png"), for: [])
        }
        else{
            print("Inside favoriting")
            tweet.favorited = true
            tweet.favoriteCount! += 1
            print(tweet.favoriteCount)
            favButton.setImage(UIImage(named: "favor-icon-red"), for: [])
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
            favoritedCount.text = String(fc)
        }
        else{
            favoritedCount.text = ""
        }
        // TODO: Send a POST request to the POST favorites/create endpoint
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
