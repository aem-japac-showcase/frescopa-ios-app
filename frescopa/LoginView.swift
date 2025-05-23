import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false // Add login state
    
    // Demo user matrix
    let userMatrix: [String: String] = [
        "mszulc": "Mark",
        "srose": "Sarah"
    ]
    
    var displayName: String? {
        userMatrix[username.lowercased()]
    }
    
    var body: some View {
        Group {
            if isLoggedIn {
                DashboardView(displayName: displayName, username: username)
            } else {
                ZStack {
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
   
                    // Login form content
                    VStack(spacing: 25) {
                        // Logo and name
                        HStack(spacing: 10) {
                            Image("FrescopaLogotype")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 236, height: 65)
                                .foregroundColor(Color(hex: "D4A019"))
                            
                        }
                        .padding(.bottom, 50)
                        
                        // Login fields
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(Color(hex: "592020"))
                            
                            TextField("", text: $username)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color(hex: "D4A019"), lineWidth: 2)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.headline)
                                .foregroundColor(Color(hex: "592020"))
                            
                            SecureField("", text: $password)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color(hex: "D4A019"), lineWidth: 2)
                                )
                        }
                        
                        // Login button
                        Button(action: {
                            // Handle login action
                            // Here you can add authentication logic if needed
                            isLoggedIn = true // Navigate to dashboard
                        }) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "006D77"))
                                .cornerRadius(28)
                        }
                        .padding(.top, 15)
                        
                        // Forgot password
                        Button(action: {
                            // Handle forgot password
                        }) {
                            Text("Forgot Password?")
                                .foregroundColor(Color(hex: "592020"))
                                .font(.system(size: 16))
                        }
                        .padding(.top, 15)
                        
                        // Create account
                        VStack(spacing: 5) {
                            Text("Don't have an account yet?")
                                .foregroundColor(Color(hex: "592020"))
                            
                            Button(action: {
                                // Handle create account
                            }) {
                                Text("Create one today")
                                    .foregroundColor(Color(hex: "C03546"))
                                    .underline()
                            }
                        }
                        .padding(.top, 15)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 80)
                }
            }
        }
    }
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
