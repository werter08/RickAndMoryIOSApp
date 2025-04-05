//
//  RMLocationListView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

protocol RMLocationListViewDelegate: AnyObject {
    func didTapped(_ listView: RMLocationListView, model: RMLocation)
}

class RMLocationListView: UIView {

    weak var delegate: (RMLocationListViewDelegate)?
    
    private var viewModel: RMLocationListViewModel? {
        didSet{
            DispatchQueue.main.async {
                self.spiner.stopAnimating()
                self.tableVie.isHidden = false
                self.tableVie.reloadData()
                UIView.animate(withDuration: 0.3) {
                    self.tableVie.alpha = 1
                }
            }
            
        }
    }
    
    private let spiner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private let tableVie: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false;
        table.alpha = 0
        table.isHidden = true
        table.register(RMLocationCellView.self, forCellReuseIdentifier: RMLocationCellView.identifier)
        return table
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)


        translatesAutoresizingMaskIntoConstraints = false
        addSubs(spiner, tableVie)
        setUpconstraints()
        tableVie.delegate = self
        tableVie.dataSource = self
        spiner.startAnimating()
        tableVie.rowHeight = UITableView.automaticDimension
        tableVie.estimatedRowHeight = 50
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpconstraints(){
        NSLayoutConstraint.activate([
            spiner.widthAnchor.constraint(equalToConstant: 100),
            spiner.heightAnchor.constraint(equalToConstant: 100),
            spiner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableVie.topAnchor.constraint(equalTo: topAnchor),
            tableVie.leftAnchor.constraint(equalTo: leftAnchor),
            tableVie.rightAnchor.constraint(equalTo: rightAnchor),
            tableVie.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(viewModel: RMLocationListViewModel){
        self.viewModel = viewModel
    }
}

extension RMLocationListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = viewModel?.getLocation(index: indexPath.row) else{
            fatalError()
        }
        delegate?.didTapped(self, model: model)
    }
}

extension RMLocationListView: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableVie.dequeueReusableCell(withIdentifier: RMLocationCellView.identifier, for: indexPath) as? RMLocationCellView, let models = viewModel?.cellModels else{
            fatalError()
        }
        let model = models[indexPath.row]
        cell.configure(module: model)
       // cell.backgroundColor = .blue
        
        return cell
    }
    
    
}
