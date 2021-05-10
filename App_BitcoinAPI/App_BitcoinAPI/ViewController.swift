//
//  ViewController.swift
//  App_BitcoinAPI
//
//  Created by Kaique Lopes on 06/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var btConsult: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.valueBitcoin()
        
    }
    @IBAction func consult(_ sender: Any) {
        self.valueBitcoin()
    }
    func formatValue(value: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let valueFinal = nf.string(from: value) {
            return valueFinal
        }
        return "0,00"
    }
    
    func valueBitcoin() {
            // MARK: - URL API
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            
            // MARK: - Verificação de erro
            let data = URLSession.shared.dataTask(with: url) { datas, request, error in
                if error == nil {
                    // MARK: - Retornando os dados
                    if let dataRequest = datas {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: dataRequest, options: []) as? [String: Any] {
                                // MARK: - Retornando Valores
                                if let brl = json["BRL"] as? [String: Any] {
                                    if let buy = brl["buy"] as? Double {
                                        print(buy)
                                    }
                                }
                                
                            }
                            
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

