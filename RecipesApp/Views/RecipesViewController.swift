//
//  RecipesViewController.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 10/11/23.
//

import UIKit

class RecipesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipeTableView: UITableView!
    
    var viewModel = RecipesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViews()
        viewModel.getRecipes()
    }
    
    func setupDelegates(){
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        viewModel.delegate = self
        searchBar.delegate = self
        view.addSpinner()
    }
    
    func setupViews() {
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
        return viewModel.recipes.count
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewControllerId") as? RecipeDetailViewController  else {
            return
        }

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

extension RecipesViewController: RecipesViewModelDelegate {
    func success(_ viewModel: RecipesViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view.removeSpinner()
            self?.recipeTableView.reloadData()
        }
    }
    
    func error(_ viewModel: RecipesViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view.removeSpinner()
        }
        self.showErrorAlert(error: "No se pudo cargar las recetas")
    }
}
