//
//  ViewController.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    var arrayDeFilmes: [studioGhibli] = []
    let api = API()
    let reuseIdentifier = "Celula"


    lazy var tabelaFilmes: UITableView = {

        var tabela = UITableView()
        tabela.frame = self.view.bounds
        tabela.dataSource = self
        tabela.delegate = self
        
        let nib = UINib(nibName: "CelulaCustomizadaMain", bundle: nil)
        tabela.register(nib, forCellReuseIdentifier: reuseIdentifier)
        
        return tabela

    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Studio Ghibli Movies"
        
        self.view.addSubview(self.tabelaFilmes)
        
        self.populaArrayDeFilmes()
        
        self.createRightBarButton()
        
        self.view.backgroundColor = UIColor.meuRosa()
        self.tabelaFilmes.backgroundColor = .clear
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        footer.backgroundColor = .meuRoxo()
        tabelaFilmes.tableFooterView = footer
    }
    
//criando funcao para popular a api
        func populaArrayDeFilmes() {
            api.getSG(urlString: api.setSGURL, method: .GET) { modelresponse, error in

                if let array = modelresponse {

                    DispatchQueue.main.async {
                        self.arrayDeFilmes = array
                        //print(self.arrayDeFilmes.debugDescription)
                        self.tabelaFilmes.reloadData()
                    }
                }
                switch error {
                case .serverError: self.userAlert(mensagem: "No Internet connection")
                default: break
                }
            }
        }
    
//funcao para mostrar erro de sem intenrnet na tela
    func userAlert(mensagem: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Warning", message: mensagem, preferredStyle: .alert)
            
            let buttonBack = UIAlertAction(title: "Try Again", style: .default) { _ in
                self.populaArrayDeFilmes()
            }
            let buttonOk = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

            alert.addAction(buttonBack)
            alert.addAction(buttonOk)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
//botao que leva aos favoritos
    func createRightBarButton() {
        
        let heartImage = UIImage(systemName: "heart.fill")
        
        let rightButton = UIBarButtonItem(image: heartImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(getFavoritos))
        rightButton.tintColor = .red
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func getFavoritos() {
        let favVC = FavoritesViewController()
        self.show(favVC, sender: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayDeFilmes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//editando a celula customizada
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as? CelulaCustomizadaMain
        
        
        cell?.uITituloMain.text = self.arrayDeFilmes[indexPath.row].title
        cell?.uIDescription.text = self.arrayDeFilmes[indexPath.row].description
        cell?.uIDescription.adjustsFontSizeToFitWidth = false
        cell?.uIDescription.numberOfLines = 0
        
        if let image = self.arrayDeFilmes[indexPath.row].image {
                    
            let url = URL(string: image)
         
//usando kingfisher para configurar a imagem
            cell?.uIImageMain.kf.setImage(with: url, options: [.transition(ImageTransition.fade(2.0)), .cacheOriginalImage],
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

//mandando para a tela de detalhes
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = DetailViewController()
        
        detail.sGTocado = self.arrayDeFilmes[indexPath.row]
        
        self.show(detail, sender: nil)
    }
    
}


