//
//  ContentView.swift
//  tinypasswordgenapp
//
//  Created by corrado.ignoti on 24/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var digitIsOn: Bool = true
    @State private var uderscoreIsOn: Bool = false
    @State private var specialCharIsOn: Bool = false
    
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack (alignment: .leading){
            Text("This is a password generated for you")
                .padding()
                .foregroundStyle(Color .gray)
                .font(.title3)
            Text("\(viewModel.generatedPassword)")
                .font(.custom("OxygenMono-Regular", size: 30))
                .bold()
                .foregroundStyle(Color .white)
                .padding(.bottom, 50)
                .padding()
                .textSelection(.enabled)
            Text("Options:")
                .font(.headline)
                .foregroundStyle(Color .gray)
                .padding()
                .bold()
            Group() {
                VStack(alignment: .leading){
                    Toggle("Digit", isOn: $digitIsOn)
                        .onChange(of: digitIsOn) {
                            viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: 3)
                        }
                    Text("Add a random number")
                        .font(.footnote)
                }.padding()
                
                VStack(alignment: .leading){
                    Toggle("Underscore", isOn: $uderscoreIsOn)
                        .onChange(of: uderscoreIsOn) {
                            viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: 3)
                        }
                    Text("Use underscore (_) instead of hyphen (-) to separate words")
                        .font(.footnote)
                }
                .padding()
                
                VStack(alignment: .leading){
                    Toggle("Special characters", isOn: $specialCharIsOn)
                        .onChange(of: specialCharIsOn) {
                            viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: 3)
                        }
                    Text("Use special chars")
                        .font(.footnote)
                }
                .padding()
            }
            .padding(.bottom, 5)
            .padding(.leading, 20)
            .padding(.trailing, 40)
            .font(.body)
            .foregroundStyle(Color .white)
            Text("Shake to regenerate...")
                .foregroundStyle(Color .gray)
                .font(.headline)
                .padding()
            HStack(){
                Label("Be wear!", systemImage: "exclamationmark.triangle")
                    .labelStyle(.iconOnly)
                    .font(.title)
                    .padding(.horizontal)
                Text("Take note of the password: for security reasons it will not be stored anywhere and, so, it can't be recovered in any way")
                    .foregroundStyle(Color .gray)
                    .font(.headline)
                
            }
            .padding()
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background{
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
        }
        .onShake{
            viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: 3)
        }
        .onAppear{
            viewModel.generatePassword(useDigit: digitIsOn, useUnderscore: uderscoreIsOn, useSpecialChar: specialCharIsOn, numberOfWords: 3)
        }
    }
}

#Preview {
    ContentView()
}
