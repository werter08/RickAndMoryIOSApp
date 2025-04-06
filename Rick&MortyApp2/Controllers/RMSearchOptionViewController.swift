//
//  RMSearchViewController.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

class RMSearchOptionViewController: UIViewController, UITableViewDelegate {
    

    private let option: RMSearchInputViewModel.options
    
    public var sectionBlok: (String) -> Void
    
    private var tableView:UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return view
    }()

    
    
    
    //MARK: - Init
    
    init(option: RMSearchInputViewModel.options, selection: @escaping (String) -> Void) {
        self.option = option
        self.sectionBlok = selection
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .secondarySystemBackground

        setUpConstraints()
    }
   
    func setUpConstraints(){

        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension RMSearchOptionViewController: UITextViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = option.sections[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = option.sections[indexPath.row]
        self.sectionBlok(name)
        dismiss(animated: true)
    }
    
    
    
}

