//
//  DetailViewController.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    let reuseIdentifier = "Celula"
    var sGTocado: studioGhibli = studioGhibli()

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
        self.view.addSubview(self.tabelaFilmes)
        self.title = "Movie Details"
        self.view.backgroundColor = UIColor.meuRosa()
        self.tabelaFilmes.backgroundColor = .meuRosa()
       
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        footer.backgroundColor = .meuRoxo()
        tabelaFilmes.tableFooterView = footer
        
        _ = verifyFavorite()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabelaFilmes.reloadData()
    }
}

//MARK: UITableViewDataSource
//determinando numero de itens
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
            
//determinando o conteúdo das células
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .none
        cell.detailTextLabel?.textAlignment = .justified
        cell.detailTextLabel?.textColor = .meuCinza()
        cell.backgroundColor = .meuRosa()
        cell.detailTextLabel?.font =  UIFont(name: "Kohinoor Bangla Semibold", size: 16.0)
        
        switch indexPath.row {
        case 0:
            
            let cellImage = ImageViewCell()
            guard let urlString = sGTocado.image else { return UITableViewCell() }
            guard let url = URL(string: urlString) else { return UITableViewCell() }
            cellImage.setImageView(url: url, rounded: true)
            cellImage.backgroundColor = .meuRosa()
            return cellImage
            
        case 1:
            guard let title = sGTocado.title else { return UITableViewCell() }
            cell.textLabel?.text = "Title:"
            cell.detailTextLabel?.text = title
        case 2:
            guard let original_title = sGTocado.original_title else { return UITableViewCell() }
            cell.textLabel?.text = "Japanese Title:"
            cell.detailTextLabel?.text = original_title
        case 3:
            guard let director = sGTocado.director else { return UITableViewCell() }
            cell.textLabel?.text = "Director:"
            cell.detailTextLabel?.text = director
        case 4:
            guard let producer = sGTocado.producer else { return UITableViewCell() }
            cell.textLabel?.text = "Producer:"
            cell.detailTextLabel?.text = producer
        case 5:
            guard let release_date = sGTocado.release_date else { return UITableViewCell() }
            cell.textLabel?.text = "Release Date:"
            cell.detailTextLabel?.text = release_date
        case 6:
            guard let running_time = sGTocado.running_time else { return UITableViewCell() }
            cell.textLabel?.text = "Running Time:"
            cell.detailTextLabel?.text = running_time
        case 7:
            guard let rt_score = sGTocado.rt_score else { return UITableViewCell() }
            cell.textLabel?.text = "Rotten Tomatoes Score:"
            cell.detailTextLabel?.text = rt_score
        case 8:
            guard let description = sGTocado.description else { return UITableViewCell() }
            cell.textLabel?.text = "Description:"
            cell.detailTextLabel?.text = description
            cell.detailTextLabel?.numberOfLines = 0
        case 9:
            let cellbanner = ImageViewCell()
           guard let urlString = sGTocado.movie_banner else { return UITableViewCell() }
           guard let url = URL(string: urlString) else { return UITableViewCell() }
           cellbanner.setImageView(url: url, rounded: true)
           cellbanner.backgroundColor = .meuRosa()
           return cellbanner
        case 10:
            return self.showFavoriteButton()
        
            default:
            return UITableViewCell()
        }

        
        return cell
    }

//configurando os botoes de adicionar
    func cellAddFavorites() -> UITableViewCell {
       let cell = FavoriteTableViewCell()
        
        cell.imageView?.image = UIImage(systemName: "star.fill")
        cell.imageView?.tintColor = .yellow
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = "Add to favorites"
        cell.backgroundColor = .meuRoxo()
        
        return cell
    }
    
    func cellOkFavorites() -> UITableViewCell {
        let cell = FavoriteTableViewCell()
         
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = "Is already added!"
        cell.backgroundColor = .meuRoxo()
         
         return cell
    }
    
}

//MARK: UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
 //daqui pra baixo estou configurando os favoritos
        
       if indexPath.row == 10 {
           if !verifyFavorite() {
               addFavorites()
           }
 
        }
        
    }
    
//botao da forma que ficou na tableviewcell
    func showFavoriteButton() -> UITableViewCell {
        
            if verifyFavorite() {
                return self.cellOkFavorites()
            } else {
                return self.cellAddFavorites()
            }
    }
    
//funcao que verifica os dados no coredata
    func verifyFavorite() -> Bool {
        
        let context = DataBaseController.persistentContainer.viewContext
        
        var isFavorite: Bool = false
        
        do {
            
            if let cdid = sGTocado.id {
            
                let fetchRequest = InfosFilmesCD.fetchRequest()
                
                let predicate = NSPredicate(format: "cdid == %@", cdid)
                fetchRequest.predicate = predicate
                
                let favoritefilm = try context.fetch(fetchRequest)
                if favoritefilm.count > 0 {
                    isFavorite = true
                } else {
                    isFavorite = false
                }
            }
        } catch {
            print("Error")
        
        }
        return isFavorite
    }
    
    func addFavorites() {
        if let cdid = sGTocado.id,
           let cdtitle = sGTocado.title,
           let cdoriginal_title = sGTocado.original_title,
           let cdimage = sGTocado.image,
           let cdmovie_banner = sGTocado.movie_banner,
           let cddescription = sGTocado.description,
           let cddirector = sGTocado.director,
           let cdproducer = sGTocado.producer,
           let cdrelease_date = sGTocado.release_date,
           let cdrunning_time = sGTocado.running_time,
           let cdrt_score = sGTocado.rt_score {
            
            if !self.verifyFavorite() {
                let context = DataBaseController.persistentContainer.viewContext
                let sgmovies = InfosFilmesCD(context: context)
                sgmovies.cdid = cdid
                sgmovies.cdtitle = cdtitle
                sgmovies.cdoriginal_title = cdoriginal_title
                sgmovies.cdimage = cdimage
                sgmovies.cdmovie_banner = cdmovie_banner
                sgmovies.cddescription = cddescription
                sgmovies.cddirector = cddirector
                sgmovies.cdproducer = cdproducer
                sgmovies.cdrelease_date = cdrelease_date
                sgmovies.cdrunning_time = cdrunning_time
                sgmovies.cdrt_score = cdrt_score
                DataBaseController.saveContext()
                self.tabelaFilmes.reloadData()
                _ = verifyFavorite()
            }
        }
    }
    
}
