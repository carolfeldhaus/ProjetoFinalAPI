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
        
        self.title = "Favorites"
        
        self.view.backgroundColor = UIColor.meuRosa()
        self.tabelaFilmes.backgroundColor = .meuRosa()
        
        let nibFavorite = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        tabelaFilmes.register(nibFavorite, forCellReuseIdentifier: FavoriteTableViewCell.favoriteCell)
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        footer.backgroundColor = .meuRoxo()
        tabelaFilmes.tableFooterView = footer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableViewAddFavorites()
    }
    
    func reloadTableViewAddFavorites() {
        do {
            self.favoriteSG = try DataBaseController.persistentContainer.viewContext.fetch(InfosFilmesCD.fetchRequest())
        } catch {
            print("Erro no banco de dados")
        }
        self.tabelaFilmes.reloadData()
    }
    
    func reloadTableViewRemoveFavorites() {
        
    }
}

//MARK: UITableViewDataSource
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

//MARK: UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
   
        //deletar dos favoritos
            func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
                    return UITableViewCell.EditingStyle.delete
                }
        
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                
                let teste = favoriteSG[indexPath.row]
                let context = DataBaseController.persistentContainer.viewContext
                if editingStyle == .delete {
                    context.delete(teste)
                    do{
                        try context.save()
                    } catch {
                        
                    }
                
                self.favoriteSG.remove(at: indexPath.row)
                tabelaFilmes.reloadData()
            }
        }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        
        let favEntity = favoriteSG[indexPath.row]
        
        var imagemovie = ImageFilme()
        imagemovie.url = favEntity.cdimage
        
        var imagebanner = ImageFilme()
        imagebanner.url = favEntity.cdmovie_banner
        
        var new: studioGhibli = studioGhibli()
        new.title = favEntity.cdtitle
        new.original_title = favEntity.cdoriginal_title
        new.image = imagemovie.url
        new.movie_banner = imagebanner.url
        new.description = favEntity.description
        new.director = favEntity.cddirector
        new.producer = favEntity.cdproducer
        new.release_date = favEntity.cdrelease_date
        new.running_time = favEntity.cdrunning_time
        new.rt_score = favEntity.cdrt_score
        new.description = favEntity.cddescription
        
        detail.sGTocado = new
        
        self.show(detail, sender: self)
    }
        
}


