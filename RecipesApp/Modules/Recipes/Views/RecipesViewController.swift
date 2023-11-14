//
//  RecipesViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit

protocol RecipesViewControllerProtocol:AnyObject {
    func reloadTableView()
    func error(error: String)
}

class RecipesViewController: UIViewController {
    
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var recipeTableView: UITableView!
    
    var viewModel: RecipesViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViews()
        viewModel?.getRecipes()
    }
    
    private func setupDelegates(){
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        searchBar.delegate = self
        view.addSpinner()
    }
    
    private func setupViews() {
        self.title = "Peruvian Recipes"
        recipeTableView.register(UINib(nibName: "RecipesTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipesTableViewCell")
        recipeTableView.backgroundColor = .clear
        recipeTableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0)
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
        let vc = RecipeDetailViewController(nibName: "RecipeDetailViewController", bundle: nil)
        let recipe = viewModel.recipeForCellAtIndex(indexPath.row)
        vc.viewModel = RecipeDetailViewModel(recipeId: recipe.recipeId,location: recipe.origen, view: vc)
        
        navigationController?.pushViewController(vc, animated: true)
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
        view.removeSpinner()
        recipeTableView.reloadData()
    }
    
    func error(error: String) {
        view.removeSpinner()
        showErrorAlert(error: error)
    }

}
