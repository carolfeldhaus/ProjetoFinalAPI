//
//  FavoritesViewController.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import Foundation
import UIKit
import Kingfisher

class FavoritesViewController: UIViewController {

    var favoriteSG: [InfosFilmesCD] = []
    var reuseIdentifier = "favoriteCell"
    
    lazy var tabelaFilmes: UITableView = {

        var tabela = UITableView()
        tabela.frame = self.view.bounds
        tabela.dataSource = self
        tabela.delegate = self
        tabela.separatorStyle = .none

        return tabela

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(self.tabelaFilmes)
        
        self.view.backgroundColor = UIColor.meuRosa()
        self.tabelaFilmes.backgroundColor = .meuRosa()
        
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
        
        cell?.uiTitleFav.text = favfilm.cdtitle
  
    if let image = favfilm.cdimage {
        
            guard let url = URL(string: image) else { return UITableViewCell() }
        
        //usando kingfisher para configurar a imagem
                    cell?.uiImageFav.kf.setImage(with: url, options: [.transition(ImageTransition.fade(2.0)), .cacheOriginalImage],
                                                  progressBlock: nil, completionHandler: { resultado in
                            switch resultado {
                            case .success(let image):
                                print(image.cacheType)
                            case .failure(let erro):
                                print(erro.localizedDescription)
                            }
                        })
                }
                return cell!
    }

    //configurando o tamanho da linha
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 146.0
        }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        
        let favEntity = favoriteSG[indexPath.row]
        
        var imagemovie = ImageFilme()
        imagemovie.url = favEntity.cdimage
        
        var imagebanner = ImageFilme()
        imagebanner.url = favEntity.cdmovie_banner
        
        var newTouched: studioGhibli = studioGhibli()
        newTouched.title = favEntity.cdtitle
        newTouched.original_title = favEntity.cdoriginal_title
        newTouched.image = imagemovie.url
        newTouched.movie_banner = imagebanner.url
        newTouched.description = favEntity.description
        newTouched.director = favEntity.cddirector
        newTouched.producer = favEntity.cdproducer
        newTouched.release_date = favEntity.cdrelease_date
        newTouched.running_time = favEntity.cdrunning_time
        newTouched.rt_score = favEntity.cdrt_score
        newTouched.description = favEntity.cddescription
        
        detail.sGTocado = newTouched
        
        self.show(detail, sender: self)
    }
}


