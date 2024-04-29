//
//  viewModel.swift
//  tinypasswordgenapp
//
//  Created by corrado.ignoti on 29/04/24.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published  var generatedPassword: String = ""
    
    private var wordsList: [String] = []
    private let special_characters = "!&'()/;^[]{}~"
    
    init(){
        let url = Bundle.main.url(forResource: "en_words", withExtension: "txt")!
        do {
            let string = try String(contentsOf: url, encoding: .utf8)
            self.wordsList = string.components(separatedBy: CharacterSet.newlines)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func generatePassword(useDigit: Bool, useUnderscore: Bool, useSpecialChar: Bool, numberOfWords: Int) {
        var gpassword: String = ""
        
        let wordsList = generateRandomWords(wordsCount: numberOfWords - 1)
        
        for item in wordsList {
            if useUnderscore {
                gpassword += item + "_"
            } else {
                gpassword += item + "-"
            }
        }
        
        if useDigit {
            let rndDigitPart = Int(arc4random_uniform(UInt32(99)) + 1)
            gpassword += String(rndDigitPart)
        } else {
            gpassword = String(gpassword.dropLast()) //Delete last "-" from password
        }
        
        if useSpecialChar {
            let random_index = Int(arc4random_uniform(UInt32(self.special_characters.count)) + 1)
            gpassword += self.special_characters[random_index]
        }
        
        self.generatedPassword = gpassword
    }
    
    private func generateRandomWords(wordsCount: Int) -> [String]{
        var randonWordsList: [String] = []
        
        for _ in 0...wordsCount {
            let random_index = Int(arc4random_uniform(UInt32(self.wordsList.count)) + 1)
            randonWordsList.append(wordsList[random_index])
        }
        
        return randonWordsList
    }
}
