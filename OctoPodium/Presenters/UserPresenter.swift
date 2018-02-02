//
//  TopUserPresenter.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 18/12/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

protocol TopUserView {
    
}

struct UserPresenter {
    
    let user: User
    let ranking: Int
    
    let totalRepositories: Int
    let totalStars: Int
    let totalTrophies: Int
    
    private let medalImages = [#imageLiteral(resourceName: "GoldMedal"), #imageLiteral(resourceName: "SilverMedal"), #imageLiteral(resourceName: "BronzeMedal")]
    
    private let positionColors: [UInt] = [
        kColors.firstInRankingColor,
        kColors.secondInRankingColor,
        kColors.thirdInRankingColor
    ]
    
    private let avatarBGColors: [UInt] = [
        kColors.secondInRankingColor,
        kColors.thirdInRankingColor,
        0xE5E5FF
    ]
    
    init(user: User, ranking: Int) {
        self.user = user
        self.ranking = ranking
        
        let reposStarsTrophies = UserPresenter.getReposStarsAndTrophiesFrom(user)
        totalRepositories = reposStarsTrophies.repos
        totalStars = reposStarsTrophies.stars
        totalTrophies = reposStarsTrophies.trophies
    }
    
    private static func getReposStarsAndTrophiesFrom(_ user: User) -> (repos: Int, stars: Int, trophies: Int) {
        let initialTuple = (repos: 0, stars: 0, trophies: 0)
        
        return user.rankings.reduce(initialTuple) { (tuple, ranking) -> (repos: Int, stars: Int, trophies: Int) in
            let repos = tuple.repos + (ranking.repositories ?? 0)
            let stars = tuple.stars + (ranking.stars)
            let trophies = tuple.trophies + ranking.trophies
            return (repos: repos, stars: stars, trophies: trophies)
        }
    }
    
    init(user: User) {
        var ranking = 0
        if user.rankings.count > 0 {
            let topRanking = user.rankings[0]
            ranking = topRanking.cityRanking ?? (topRanking.countryRanking ?? (topRanking.worldRanking ?? 0))
        }
        self.init(user: user, ranking: ranking)
    }
    
    var isPodiumRanking: Bool {
        return (1..<4).contains(ranking)
    }

    var rankingImage: UIImage? {

        guard isPodiumRanking else { return nil }

        return medalImages[ranking - 1]
    }
    
    func backgroundColor() -> UInt? {

        guard isPodiumRanking else { return nil }

        return positionColors[ranking - 1]
    }

    func avatarBackgroundColor() -> UInt? {

        guard isPodiumRanking else { return nil }

        return avatarBGColors[ranking - 1]
    }
    
    var login: String {
        return user.login
    }
    
    var avatarUrl: String? {
        return user.avatarUrl
    }
    
    var stars: String {
        return "\(user.starsCount ?? 0)"
    }
    
    var hasLocation: Bool {
        return user.hasLocation
    }
    
    var cityOrCountryOrWorld: String {
        if let city = user.city { return city }
        if let country = user.country { return country }
        return "the world"
    }
    
    var fullLocation: String {

        let city = user.city?.capitalized
        let country = user.country?.capitalized

        return String.join(", ", country, city)
    }
    
    var gitHubUrl: String {

        return "https://www.github.com/\(user.login)"
    }
    
}
