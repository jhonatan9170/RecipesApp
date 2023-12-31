//
//  RecipesViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit

protocol RecipesViewControllerProtocol:AnyObject {
    func reloadTableView()
    func updateSpinner(loading: Bool)
}

class RecipesViewController: UIViewController {
    
    @IBOutlet weak private var searchBar: UISearchBar! {
        didSet{
            searchBar.delegate = self
        }
    }
    @IBOutlet weak private var recipeTableView: UITableView!{
        didSet{
            recipeTableView.dataSource = self
            recipeTableView.delegate = self
            recipeTableView.register(UINib(nibName: "RecipesTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipesTableViewCell")
            recipeTableView.backgroundColor = .clear
            recipeTableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0)
        }
    }
    
    private var viewModel: RecipesViewModelProtocol

    init(viewModel: RecipesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: RecipesViewController.self), bundle: Bundle.main)
        self.viewModel.setViewControllerProtocol(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.getRecipes()
    }
    
    private func setupView() {
        self.title = "Peruvian Recipes"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
    }
    
}
extension RecipesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipesToShow.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        let recipe = viewModel.recipeForCellAtIndex(indexPath.row)
        cell.configure(title: recipe.recipeName, url: recipe.imageSrc ?? "")
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showDetail(index: indexPath.row)
    }
}

extension RecipesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.cleanFilter()
        } else {
            viewModel.filterByName(text: searchText)}
    }
}

extension RecipesViewController: RecipesViewControllerProtocol{
    
    func reloadTableView() {
        recipeTableView.reloadData()
    }
    
    func updateSpinner(loading: Bool){
        loading ? view.addSpinner() : view.removeSpinner()
    }
}
