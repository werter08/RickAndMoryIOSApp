//
//  RMSearchView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func didSelected(_ view: RMSearchInputView, option: RMSearchInputViewModel.options)
    func searchButtonClicked(_ view: RMSearchInputView)
    func TextChanged(_ view: RMSearchInputView,text: String)
}


class RMSearchInputView: UIView {

    var delegate: (RMSearchInputViewDelegate)?
    
    private var viewModel: RMSearchInputViewModel? {
        didSet {
            verticalStack.addArrangedSubview(searchInputView)
            
            guard let viewM = viewModel, viewModel!.hasOptionButtons else {
                return
            }
           let optins = viewM.optionButtonTitles
            SetOptionButtons(options: optins)
        }
    }
    
    //MARK: - UI
    
    private var searchInputView: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.searchTextField.font = .monospacedDigitSystemFont(ofSize: 18, weight: .medium)
        return search
    }()
   
    private var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical


        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        return stack
 
    }()
    private var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        return stack
    }()

    
    
    //MARK: - init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStack)
        setNoSerachConstraint()
        searchInputView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Constraints
    
    func setNoSerachConstraint(){
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            verticalStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            horizontalStack.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    //MARK: - Configure
    
    func configure(viewmodel: RMSearchInputViewModel){
        searchInputView.placeholder = viewmodel.searchPlaceHolder
        self.viewModel = viewmodel
        
    }
    
    
    
    func SetOptionButtons(options: [RMSearchInputViewModel.options]){
        if options.isEmpty {return}
        
        for x in 0..<options.count {
            let button = createButton(option: options[x])
            button.tag = x
          
            horizontalStack.addArrangedSubview(button)
            
        }

        verticalStack.addArrangedSubview(horizontalStack)
    }
    
    
    
    func presentKeyboard(){
        searchInputView.becomeFirstResponder()
    }
    
    //MARK: - Factory
    
    func createButton(option: RMSearchInputViewModel.options) -> UIButton{
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(
            string: option.rawValue,
            attributes: [
                .font: UIFont.systemFont(ofSize: 22, weight: .semibold),
                .foregroundColor: UIColor.label
            ]
        ), for: .normal)
        button.backgroundColor = option.colors
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        guard let options = viewModel?.optionButtonTitles else {
            fatalError()
        }
        
        let tag = sender.tag
        delegate?.didSelected(self, option: options[tag])
        
    }
    
    //MARK: - Get option change
    public func ChangeOptionTitle(option: RMSearchInputViewModel.options, value: String) {
        print(option.rawValue + " " + value)
        guard let buttons = horizontalStack.arrangedSubviews as? [UIButton],
              let options = viewModel?.optionButtonTitles,
              let index = options.firstIndex(of: option) else{
            fatalError()
        }
        let button = buttons[index]
        button.setAttributedTitle(NSAttributedString(
            string: value.uppercased(),
            attributes: [
                .font: UIFont.systemFont(ofSize: 22, weight: .bold),
                .foregroundColor: UIColor.link
            ]
        ), for: .normal)
    }
}
extension RMSearchInputView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.searchButtonClicked(self)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.TextChanged(self, text: searchText)
        print(searchText)
    }
    
}
