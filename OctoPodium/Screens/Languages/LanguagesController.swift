//
//  LanguagesController.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 25/11/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias Language = String

class LanguagesController: UIViewController {
    
    @IBOutlet weak var searchBar: SearchBar!
    @IBOutlet weak var languagesTable: UITableView!
    @IBOutlet weak var loadingIndicator: GithubLoadingView?
    @IBOutlet weak var tryAgainButton: UIButton!
    
    @IBAction func tryAgainClicked() {
        searchLanguages()
    }
    
    fileprivate var allLanguages: [Language] = []
    fileprivate var displayingLanguages: BehaviorRelay<[Language]> = BehaviorRelay(value: [])

    fileprivate var selectedLanguage: Language!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        languagesTable.contentInset.top = 44
        searchLanguages()
        languagesTable.registerReusableCell(LanguageCell.self)
        Analytics.SendToGoogle.enteredScreen(kAnalytics.languagesScreen)

        searchBar.rx.text.subscribe(onNext: { [weak self] query in
            guard let strongSelf = self else { return }

            let searchText = query ?? ""

            if searchText == "" {
                strongSelf.displayingLanguages.accept(strongSelf.allLanguages)
            } else {
                let resultPredicate = NSPredicate(format: "self contains[c] %@", searchText)
                let filtered = strongSelf.allLanguages.filter { resultPredicate.evaluate(with: $0) }
                strongSelf.displayingLanguages.accept(filtered)
            }
            strongSelf.languagesTable.reloadData()
        }).disposed(by: disposeBag)

        displayingLanguages.bind(to: languagesTable.rx.items(cellIdentifier: LanguageCell.reuseIdentifier)) {
            (index, language: Language, cell) in
            (cell as! LanguageCell).language = language
        }.disposed(by: disposeBag)

        displayingLanguages.asObservable().subscribe { [weak self] _ in

            self?.endSearching()
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegues.showLanguageRankingSegue {
            segue.rankingsController.language = selectedLanguage
        }
    }
    
    private func searchLanguages() {
        setSearching()
        Languages.Get().all { [weak self] result in

            switch result {

            case let .success(languages):

                self?.allLanguages = languages
                self?.displayingLanguages.accept(languages)

            case let .failure(apiResponse):

                self?.tryAgainButton.show()
                self?.loadingIndicator?.hide()

                NotifyError.display(apiResponse.status.message())
            }
        }
    }
    
    private func setSearching() {
        
        languagesTable.hide()
        tryAgainButton.hide()
        loadingIndicator?.show()
    }
    
    fileprivate func endSearching() {
        languagesTable.show()
        tryAgainButton.hide()
        loadingIndicator?.hide()
    }
}

extension LanguagesController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = displayingLanguages.value[indexPath.row]
        performSegue(withIdentifier: kSegues.showLanguageRankingSegue, sender: self)
        languagesTable.deselectRow(at: indexPath, animated: false)
    }
}

extension UIStoryboardSegue {
    
    fileprivate var rankingsController: LanguageRankingsController {
        return destination as! LanguageRankingsController
    }
}
