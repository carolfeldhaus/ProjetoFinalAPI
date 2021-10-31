//
//  FavoritesViewController.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {

    var favoriteSG: [InfosFilmesCD] = []
    var reuseIdentifier = "favoriteCell"
    
    lazy var tabelaFilmes: UITableView = {

        var tabela = UITableView()
        tabela.frame = self.view.bounds
        tabela.dataSource = self
        tabela.delegate = self
        tabela.separatorStyle = .none
     //   tabela.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header)

        return tabela

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(self.tabelaFilmes)
        
        let nibFavorite = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        tabelaFilmes.register(nibFavorite, forCellReuseIdentifier: FavoriteTableViewCell.favoriteCell)
        
        self.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableViewAddFavorites()
    }
    
    func reloadTableViewAddFavorites() {
        do {
            self.favoriteSG = try DataBaseController.persistentContainer.viewContext.fetch(InfosFilmesCD.fetchRequest())
        } catch {
            print("Não consegui trazer informações do banco de dados!")
        }
        self.tabelaFilmes.reloadData()
    }
    
    func reloadTableViewRemoveFavorites() {
        
    }
}

extension FavoritesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.favoriteSG.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.favoriteCell, for: indexPath) as? FavoriteTableViewCell
        
        let favfilm = favoriteSG[indexPath.row]
        
        cell?.accessoryType = .disclosureIndicator
        
        cell?.uiTitleFav.text = favfilm.cdtitle
  
    if let image = favfilm.cdimage {
            guard let url = URL(string: image) else { return UITableViewCell() }
                let data = try? Data(contentsOf: url)
                cell?.uiImageFav.image = UIImage(data: data!)
        } else {
           print("Error")
        }
        
        return cell!
    }


}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        
        let favEntity = favoriteSG[indexPath.row]
        
        var imagemovie = ImageFilme()
        imagemovie.url = favEntity.cdimage
        
        var newTouched: studioGhibli = studioGhibli()
        newTouched.title = favEntity.cdtitle
        newTouched.original_title = favEntity.cdoriginal_title
        newTouched.image = imagemovie.url
        newTouched.movie_banner = imagemovie.url
        newTouched.description = favEntity.description
        newTouched.director = favEntity.cddirector
        newTouched.producer = favEntity.cdproducer
        newTouched.release_date = favEntity.cdrelease_date
        newTouched.running_time = favEntity.cdrunning_time
        newTouched.rt_score = favEntity.cdrt_score
        
        detail.sGTocado = newTouched
        
        self.show(detail, sender: self)
    }
}

