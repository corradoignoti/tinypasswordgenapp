//
//  ContentView.swift
//  tinypasswordgenapp
//
//  Created by corrado.ignoti on 24/04/24.
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

import SwiftUI

struct ContentView: View {
    @State private var digitIsOn: Bool = true
    @State private var uderscoreIsOn: Bool = false
    @State private var specialCharIsOn: Bool = false
    @State private var numOfWords: Double = 3
    
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            VStack (alignment: .center){
                Text("\(viewModel.generatedPassword)")
                    .font(.custom("OxygenMono-Regular", size: 20))
                    .lineLimit(5)
                    .foregroundStyle(Color .white)
                    .frame(width: 350, height: 100, alignment: .center)
                    .minimumScaleFactor(0.5)
                    .padding(.top, 30)
                    .padding()
                    .textSelection(.enabled)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = viewModel.generatedPassword
                        }) {
                            Label("Copy to clipboard", systemImage: "doc.on.doc")
                        }
                    }
                
                Text("Options:")
                    .font(.headline)
                    .foregroundStyle(Color .white)
                    .padding(.horizontal)
                    .bold()
                Group() {
                    VStack(alignment: .leading){
                        Toggle("Digit", isOn: $digitIsOn)
                            .onChange(of: digitIsOn) {
                                viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: Int(numOfWords))
                            }
                        Text("Add a random digit")
                            .font(.footnote)
                    }.padding()
                    
                    VStack(alignment: .leading){
                        Toggle("Underscore", isOn: $uderscoreIsOn)
                            .onChange(of: uderscoreIsOn) {
                                viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: Int(numOfWords))
                            }
                        Text("Use underscore (_) instead of hyphen (-) to separate words")
                            .font(.footnote)
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        Toggle("Special characters", isOn: $specialCharIsOn)
                            .onChange(of: specialCharIsOn) {
                                viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: Int(numOfWords))
                            }
                        Text("Use special chars")
                            .font(.footnote)
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        Slider(value: $numOfWords, 
                               in: 3...16,
                               step: 1)
                            .onChange(of: numOfWords) {
                                viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: Int(self.numOfWords))
                            }
                        Text("Number of words: \(Int(numOfWords))")
                            .font(.footnote)
                    }
                    .padding()
                    
                }
                .padding(.bottom, 5)
                .padding(.leading, 20)
                .padding(.trailing, 40)
                .font(.body)
                .foregroundStyle(Color .white)
                Text("Shake to generate an other password")
                    .foregroundStyle(Color .white)
                    .font(.headline)
                    .padding()
                HStack(){
                    Label("Be wear!", systemImage: "exclamationmark.triangle")
                        .labelStyle(.iconOnly)
                        .font(.title)
                        .padding(.horizontal)
                        .foregroundStyle(Color .white)
                    Text("Take note of the password: for security reasons it will not be stored anywhere and, so, it can't be recovered in any way")
                        .foregroundStyle(Color .white)
                        .font(.headline)
                    
                }
                .padding()
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background{
                //Color.black.opacity(0.8)
            Color.indigo.opacity(0.8)
                    .ignoresSafeArea()
        }
        .onShake{
            viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: Int(numOfWords))
        }
        .onAppear{
            viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: Int(numOfWords))
        }
    }
}

#Preview {
    ContentView()
}
