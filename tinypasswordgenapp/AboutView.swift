//
//  AboutView.swift
//  tinypasswordgenapp
//
//  Created by Corrado Ignoti on 11/06/25.
//


import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Sfondo con gradiente identico alla main view
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.2, green: 0.1, blue: 0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Pattern decorativo coerente
            Circle()
                .fill(Color.purple.opacity(0.1))
                .frame(width: 300)
                .offset(x: -150, y: -200)
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 200)
                .offset(x: 150, y: 300)
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack {
                        Text("About Tiny Password")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        
                        Text("Secure Password Generator")
                            .font(.subheadline)
                            .foregroundStyle(Color(white: 0.9))
                    }
                    .padding(.top, 20)
                    
                    // Card informazioni app
                    GlassCard {
                        VStack(alignment: .leading, spacing: 15) {
                            InfoRow(
                                icon: "lock.shield",
                                title: "Sicurezza",
                                description: "Tutte le password vengono generate localmente sul tuo dispositivo e non vengono mai memorizzate o trasmesse."
                            )
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            InfoRow(
                                icon: "hand.raised",
                                title: "Privacy",
                                description: "L'app non raccoglie alcun dato personale e non richiede connessione internet."
                            )
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            InfoRow(
                                icon: "sparkles",
                                title: "Open Source",
                                description: "Il codice sorgente è disponibile pubblicamente su GitHub per la verifica della comunità."
                            )
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Card sviluppatore
                    GlassCard {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("SVILUPPATORE")
                                .font(.system(.caption, design: .rounded))
                                .foregroundStyle(Color(white: 0.7))
                            
                            HStack(spacing: 15) {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Corrado Ignoti")
                                        .font(.system(.title3, design: .rounded))
                                        .foregroundStyle(.white)
                                    
                                    Text("A mobile enthusiastic")
                                        .font(.system(.subheadline, design: .rounded))
                                        .foregroundStyle(Color(white: 0.8))
                                    /*
                                    Link("Visita il mio sito", destination: URL(string: "https://example.com")!)
                                        .font(.system(.caption, design: .rounded))
                                        .tint(.blue)
                                     */
                                }
                            }
                            
                            Divider().background(Color.white.opacity(0.2))
                            
                            Text("Versione 2.0.0")
                                .font(.system(.footnote, design: .rounded))
                                .foregroundStyle(Color(white: 0.7))
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Licenza
                    GlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("LICENZA")
                                .font(.system(.caption, design: .rounded))
                                .foregroundStyle(Color(white: 0.7))
                            
                            Text("Apache License 2.0")
                                .font(.system(.body, design: .rounded))
                                .foregroundStyle(.white)
                            
                            //Password icons created by bearicons - Flaticon (https://www.flaticon.com/free-icons/password)
                            Link("App icon created by bearicons - Flaticon", destination: URL(string: "https://www.flaticon.com/free-icons/password")!)
                                .font(.system(.caption, design: .rounded))
                                .foregroundStyle(Color(white: 0.7))
                            
                            Text("Made with ❤️ by Corrado Ignoti. Licensed under the Apache License, Version 2.0.")
                                .font(.system(.footnote, design: .rounded))
                                .foregroundStyle(Color(white: 0.7))
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Bottone chiusura
                    Button(action: { dismiss() }) {
                        Text("Chiudi")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue.opacity(0.3))
                            )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

// Componente per righe informative
struct InfoRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(.white)
                
                Text(description)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(Color(white: 0.8))
            }
        }
    }
}

// Preview
#Preview {
    AboutView()
}
