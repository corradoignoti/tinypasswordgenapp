//
//  viewModel.swift
//  tinypasswordgenapp
//
//  Created by corrado.ignoti on 29/04/24.
//

/*
 Copyright 2024 Corrado Ignoti.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/

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
