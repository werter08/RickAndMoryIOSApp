//
//  RMSearchView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func didInputOptionsSelected(_ view: RMSearchInputView, option: RMSearchInputViewModel.options)
    func didTappedLocationCell(_ view: RMSearchView, model: RMLocation)
    func didTappedCharacterCell(_ view: RMSearchView, model: RMCharacter)
    func didTappedEpisodeCell(_ view: RMSearchView, model: RMEpisode)
}
 

class RMSearchView: UIView, RMSearchInputViewDelegate, RMSearchResultViewDelegate {

    


    private let ViewModel: RMSearchViewModel
    
    private let SearchInputView = RMSearchInputView()
    
    private let noSearchView = RMNoSearchView()
    
    private let SearchResultView = RMSearchResultView()
    
    var delegate: (RMSearchViewDelegate)?
    
    //MARK: - init
    
    init( viewmodel: RMSearchViewModel) {
        self.ViewModel = viewmodel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubs(noSearchView, SearchInputView, SearchResultView)
        
        setNoSerachConstraint()
        setSearchInputConstraint()
        setSearchResultConstraint()
        
        SearchInputView.delegate = self
        SearchResultView.delegate = self
        
        SearchInputView.configure(viewmodel: RMSearchInputViewModel(type: viewmodel.config.type))
        
        
        
        //MARK: - Esceping Funcs
        
        viewmodel.registerOptionChangeBlock { [weak self] option, value in
            self?.SearchInputView.ChangeOptionTitle(option: option, value: value)
        }
        viewmodel.registerSerchResultHandler { [weak self] model in
            if let result = model {
                DispatchQueue.main.async {
                    self?.noSearchView.isHidden = true
                    self?.SearchResultView.configure(viewModel: result)
                    self?.SearchResultView.isHidden = false
                }
             
            }
            else {
                DispatchQueue.main.async {
                    self?.SearchResultView.isHidden = true
                    self?.SearchResultView.alpha = 0
                    self?.noSearchView.configure(viewModel: RMNoSearchViewModel())
                    self?.noSearchView.isHidden = false
                }
            }
       
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Constraints
    
    func setNoSerachConstraint(){
        NSLayoutConstraint.activate([
            noSearchView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noSearchView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    func setSearchInputConstraint(){
        NSLayoutConstraint.activate([
            SearchInputView.topAnchor.constraint(equalTo: topAnchor),
            SearchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            SearchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            SearchInputView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    func setSearchResultConstraint(){
        NSLayoutConstraint.activate([
            SearchResultView.topAnchor.constraint(equalTo: SearchInputView.bottomAnchor),
            SearchResultView.leftAnchor.constraint(equalTo: leftAnchor),
            SearchResultView.rightAnchor.constraint(equalTo: rightAnchor),
            SearchResultView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    public func presentkeyboard(){
        SearchInputView.presentKeyboard()
    }
    
    
    //MARK: - Delegates
    
    func didSelected(_ view: RMSearchInputView, option: RMSearchInputViewModel.options) {
        delegate?.didInputOptionsSelected(view, option: option)
    }
    
    func searchButtonClicked(_ view: RMSearchInputView) {
        ViewModel.executeSearch()
    }
    func TextChanged(_ view: RMSearchInputView, text: String) {
        ViewModel.setSearchText(text: text)
    }
    func getTappedLocationCell(_ view: RMSearchResultView, at index: Int) {
        let locationModel = ViewModel.getLocationModel(at: index)
        if let locationModel {
            delegate?.didTappedLocationCell(self, model: locationModel)
        }
    }
    func getTappedEpisodeCell(_ view: RMSearchResultView, at index: Int) {
        let episodeModel = ViewModel.getEpisodeModel(at: index)
        if let episodeModel {
            delegate?.didTappedEpisodeCell(self, model: episodeModel)
        }
    }
    func getTappedCharacterCell(_ view: RMSearchResultView, at index: Int) {
        let charModel = ViewModel.getCharacterModel(at: index)
        if let charModel {
            delegate?.didTappedCharacterCell(self, model: charModel)
        }
    }
}

//MARK: - Collection

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
