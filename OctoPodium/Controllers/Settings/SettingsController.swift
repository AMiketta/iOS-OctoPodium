//
//  SettingsController.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 27/03/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

import UIKit
import StoreKit

class SettingsController : UITableViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var animationsSwitch: UISwitch!
    
    @IBAction func animationsSwitchToggled(_ animationsSwitch: UISwitch) {
        if animationsSwitch.isOn {
            Analytics.SendToGoogle.enabledAnimations()
            CurrentUser.enableAnimations()
        } else {
            Analytics.SendToGoogle.disabledAnimations()
            CurrentUser.disableAnimations()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.SendToGoogle.enteredScreen(String(describing: SettingsController.self))
        versionLabel.text = "\(K.appVersion)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = User.getUserInUserDefaults() {
            userLabel.text = user.login
            userImage.fetchAndLoad(user.avatarUrl) {
                self.tableView.reloadData()
            }
        } else {
            userImage.image = UIImage(named: "GitHub")
            userLabel.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.section, indexPath.row) == (1, 4) {
            tableView.deselectRow(at: indexPath, animated: false)
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSelectorBasedOn(indexPath)
    }
    
    let indexPathSelectors = [
        "section1row1" : "showOctoPodiumReadMe",
        "section1row2" : "starOctoPodium",
        "section1row3" : "reviewOctoPodium",
        
        "section2row0" : "developerTwitter",
        "section2row1" : "developerGithub",
    ]
    
    func performSelectorBasedOn(_ indexPath: IndexPath) {
        let key = "section\(indexPath.section)row\(indexPath.row)"
        if let selector = indexPathSelectors[key] {
            perform(Selector(selector))
        }
    }
    
    @objc func developerTwitter() {
        let _ = Twitter.Follow(username: K.twitterHandle)
    }
    
    @objc func developerGithub() {
        Browser.openPage(K.appOwnerGithub)
        Analytics.SendToGoogle.showDeveloperOnGithubEvent()
    }
    
    @objc func reviewOctoPodium() {
        Analytics.SendToGoogle.reviewInAppStoreEvent()
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {

            Browser.openPage("itms-apps://itunes.apple.com/app/id\(K.appId)")
        }
    }
    
    @objc func showOctoPodiumReadMe() {
        Analytics.SendToGoogle.viewOctoPodiumReadMeEvent()
    }
    
    @objc func starOctoPodium() {
        Analytics.SendToGoogle.starOctopodiumEvent()
        if GithubToken.instance.exists() {

            GitHub.StarRepository(repoOwner: K.appOwnerName, repoName: K.appRepositoryName)
                .doStar(starSuccessfull, failure: starFailed)
        } else {

            NotifyWarning.display("You need to login to be able to star repositories.")
        }
    }
    
    private func starSuccessfull() {
        NotifySuccess.display("OctoPodium starred successfully")
    }
    
    private func starFailed(_ apiResponse: ApiResponse) {
        NotifyError.display(apiResponse.status.message())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == kSegues.gotToTrendingDetailsFromSettingsSegue {
            let vc = segue.destination as! TrendingRepositoryDetailsController
            vc.repository = Repository(name: "\(K.appOwnerName)/\(K.appRepositoryName)", stars: "0", description: "", language: "Swift")
        }
    }
    
}
