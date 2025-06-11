import SwiftUI

struct ContentView: View {
    @State private var digitIsOn: Bool = true
    @State private var uderscoreIsOn: Bool = false
    @State private var specialCharIsOn: Bool = false
    @State private var numOfWords: Double = 3
    @State private var showCopiedMessage = false
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            // Sfondo con gradiente moderno
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.2, green: 0.1, blue: 0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Pattern decorativo
            Circle()
                .fill(Color.purple.opacity(0.1))
                .frame(width: 300)
                .offset(x: -150, y: -200)
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 200)
                .offset(x: 150, y: 300)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header con titolo
                    VStack {
                        Text("Tiny Password")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.top, 10)
                        
                        Text("Secure Password Generator")
                            .font(.subheadline)
                            .foregroundStyle(Color(white: 0.9))
                    }
                    
                    // Area password con effetto neumorfismo
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(red: 0.15, green: 0.15, blue: 0.25))
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)
                            .shadow(color: .white.opacity(0.05), radius: 10, x: -3, y: -3)
                        
                        VStack {
                            Text("\(viewModel.generatedPassword)")
                                .font(.custom("OxygenMono-Regular", size: 20))
                                .lineLimit(3)
                                .foregroundStyle(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .textSelection(.enabled)
                                .contextMenu {
                                    Button(action: copyToClipboard) {
                                        Label("Copia negli appunti", systemImage: "doc.on.doc")
                                    }
                                }
                            
                            HStack {
                                Spacer()
                                Button(action: copyToClipboard) {
                                    Label("Copia", systemImage: "doc.on.doc")
                                        .font(.footnote)
                                        .padding(8)
                                        .background(Color.blue.opacity(0.2))
                                        .clipShape(Capsule())
                                        .scaleEffect(showCopiedMessage ? 0.9 : 1.0)
                                        .opacity(showCopiedMessage ? 0.7 : 1.0)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Sezione opzioni con effetto vetro
                    VStack(alignment: .leading) {
                        Text("OPZIONI")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(Color(white: 0.8))
                            .padding(.leading, 5)
                        
                        GlassCard {
                            VStack(spacing: 20) {
                                ToggleRow(
                                    icon: "number",
                                    title: "Numeri",
                                    description: "Aggiungi un numero casuale",
                                    isOn: $digitIsOn
                                )
                                
                                Divider().background(Color.white.opacity(0.2))
                                
                                ToggleRow(
                                    icon: "underline",
                                    title: "Underscore",
                                    description: "Sostituisci trattini con _",
                                    isOn: $uderscoreIsOn
                                )
                                
                                Divider().background(Color.white.opacity(0.2))
                                
                                ToggleRow(
                                    icon: "exclamationmark.shield",
                                    title: "Caratteri speciali",
                                    description: "Aggiungi caratteri speciali",
                                    isOn: $specialCharIsOn
                                )
                                
                                Divider().background(Color.white.opacity(0.2))
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: "text.word.spacing")
                                            .foregroundStyle(.blue)
                                        Text("Numero di parole")
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Slider(value: $numOfWords, in: 3...16, step: 1)
                                        .tint(.blue)
                                    
                                    Text("\(Int(numOfWords)) parole")
                                        .font(.footnote)
                                        .foregroundStyle(Color(white: 0.8))
                                }
                            }
                            .padding()
                        }
                    }
                    .padding()
                    
                    // Bottone di generazione
                    Button(action: generatePassword) {
                        Label("Genera nuova password", systemImage: "arrow.clockwise")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    colors: [Color.blue, Color.purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal)
                    .buttonStyle(.plain)
                    
                    // Avviso di sicurezza
                    WarningCard(
                        message: "Salva la password generata: per motivi di sicurezza non verrà memorizzata e non può essere recuperata"
                    )
                    .padding()
                }
                .padding(.vertical)
            }
        }
        .onShake(perform: generatePassword)
        .onAppear(perform: generatePassword)
        .onChange(of: digitIsOn) { _ in generatePassword() }
        .onChange(of: uderscoreIsOn) { _ in generatePassword() }
        .onChange(of: specialCharIsOn) { _ in generatePassword() }
        .onChange(of: numOfWords) { _ in generatePassword() }
        .overlay(
            // Messaggio di copia confermata
            Group {
                if showCopiedMessage {
                    ConfirmationPopup()
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    showCopiedMessage = false
                                }
                            }
                        }
                }
            }
            .animation(.spring(), value: showCopiedMessage),
            alignment: .top
        )
    }
    
    private func generatePassword() {
        viewModel.generatePassword(
            useDigit: digitIsOn,
            useUnderscore: uderscoreIsOn,
            useSpecialChar: specialCharIsOn,
            numberOfWords: Int(numOfWords))
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = viewModel.generatedPassword
        
        // Mostra feedback visivo
        withAnimation {
            showCopiedMessage = true
        }
        
        // Feedback tattile
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// Componente per le righe delle opzioni
struct ToggleRow: View {
    let icon: String
    let title: String
    let description: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                Text(title)
                    .foregroundStyle(.white)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(.blue)
            }
            
            Text(description)
                .font(.footnote)
                .foregroundStyle(Color(white: 0.7))
        }
    }
}

// Card con effetto vetro
struct GlassCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(white: 0.1).opacity(0.25))
                .background(
                    Color.white.opacity(0.08)
                        .blur(radius: 10)
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
            
            content
        }
    }
}

// Componente per l'avviso di sicurezza
struct WarningCard: View {
    let message: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.yellow)
                .font(.title)
                .padding(.trailing, 10)
            
            Text(message)
                .foregroundStyle(Color(white: 0.9))
                .font(.system(.footnote, design: .rounded))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.yellow.opacity(0.15))
        )
    }
}

// Popup di conferma copia
struct ConfirmationPopup: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            Text("Copiato!")
                .foregroundColor(.white)
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(white: 0.1).opacity(0.9))
                .shadow(radius: 10)
        )
        .padding(.top, 40)
    }
}

#Preview {
    ContentView()
}
