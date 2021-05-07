//
//  ViewController.swift
//  App_BitcoinAPI
//
//  Created by Kaique Lopes on 06/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // MARK: - URL API
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            
            // MARK: - Verificação de erro
            let data = URLSession.shared.dataTask(with: url) { datas, request, error in
                if error == nil {
                        // MARK: - Retornando os dados
                    if let dataRequest = datas {
                        do {
                            let json = try JSONSerialization.jsonObject(with: dataRequest, options: [])
                            print(json)
                        } catch {
                            print("erro")
                        }
                    }
                    
                } else {
                    print("Erro ao consultar a API")
                }
            }
            data.resume()
        }
    }
}

