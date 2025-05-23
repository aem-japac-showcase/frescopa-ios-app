import SwiftUI

struct DashboardView: View {
    var displayName: String?
    var username: String
    
    // Status indicators for coffee machine
    @State private var beanLevel: Double = 0.7
    @State private var waterLevel: Double = 0.8
    @State private var cleanLevel: Double = 0.4
    
    @State private var showMenu = false
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<22: return "Good evening"
        default: return "Hello"
        }
    }
    
    var body: some View {
        ZStack {
            // Main content
            VStack(spacing: 0) {
                // Navigation header
                HStack {
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(Color(hex: "8E2426"))
                            .scaledToFit()
                            .frame(width: 43, height: 43)
                    }
                    
                    Spacer()
                
                    // Logo
                    HStack(spacing: 10) {
                        Image("FrescopaLogotype")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 185, height: 51)
                    }
                    
                    Spacer()
                    
                    // User profile icon
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 1)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Welcome section
                        VStack(alignment: .leading, spacing: 4) {
                            if let name = displayName, !name.isEmpty {
                                Text("\(greeting), \(name)")
                                    .font(.custom("Baskerville", size: 36))
                                    .foregroundColor(Color(hex: "6F2232"))
                            } else {
                                Text("\(greeting)")
                                    .font(.custom("Baskerville", size: 36))
                                    .foregroundColor(Color(hex: "6F2232"))
                            }
                            
                            Text("Your Frescopa Smart Machine")
                                .font(.custom("Baskerville", size: 24))
                                .foregroundColor(Color(hex: "6F2232"))
                                .padding(.top ,8)
                        }
                        .padding(.top)
                        .padding(.horizontal, 32.0)
                        
                        // Machine status section
                        HStack(alignment: .top, spacing: 12) {
                            // Status indicators
                            VStack(alignment: .center, spacing: 16) {
                                // Bean level
                                HStack(spacing: 10) {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(Color(hex: "6F2232"))
                                    
                                    ProgressView(value: beanLevel)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "6F2232")))
                                        .background(Color(hex: "E6D2C3"))
                                        .frame(width: 140, height: 12)
                                        .clipShape(Capsule())
                                }
                                
                                // Water level
                                HStack(spacing: 10) {
                                    Image(systemName: "drop.fill")
                                        .foregroundColor(Color(hex: "6F2232"))
                                    
                                    ProgressView(value: waterLevel)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "6F2232")))
                                        .background(Color(hex: "E6D2C3"))
                                        .frame(width: 140, height: 12)
                                        .clipShape(Capsule())
                                }
                                
                                // Clean level
                                HStack(spacing: 10) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color(hex: "6F2232"))
                                    
                                    ProgressView(value: cleanLevel)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "6F2232")))
                                        .background(Color(hex: "E6D2C3"))
                                        .frame(width: 140, height: 12)
                                        .clipShape(Capsule())
                                }
                            }
                            
                            Spacer()
                            
                            // Coffee machine image
                            Image("Machine")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 110)
                                .padding(0)
                        }
                        .padding(.horizontal, 32.0)
                        
                        // Subscription card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("MY BARISTA")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "6F2232"))
                            
                            Text("Let us do the shopping for you")
                                .font(.custom("Baskerville", size: 18))
                                .foregroundColor(Color(hex: "6F2232"))
                            
                            Button(action: {
                                // Subscribe action
                            }) {
                                Text("Subscribe")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hex: "8E2426"))
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(hex: "F9EAD6"))
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                        
                        // Coffee options grid
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            // Option 1
                            coffeeOption(name: "Frescopa Special", coffeeImage: "asset-5")
                            
                            // Option 2
                            coffeeOption(name: "Black Coffee", coffeeImage: "asset-4")
                            
                            // Option 3
                            coffeeOption(name: "Espresso", coffeeImage: "asset-3")
                            
                            // Option 4
                            coffeeOption(name: "Cappuccino", coffeeImage: "asset-2")
                            
                            // Option 5
                            coffeeOption(name: "Milk", coffeeImage: "asset-1")
                            
                            // Option 6
                            coffeeOption(name: "Water", coffeeImage: "asset-6")
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 80) // Extra space for tab bar
                    }
                }
                
                // Tab bar
                HStack(spacing: 0) {
                    tabItem(icon: "house.fill", isSelected: true)
                    tabItem(icon: "cup.and.saucer.fill", isSelected: false)
                    tabItem(icon: "leaf.fill", isSelected: false)
                    tabItem(icon: "cart.fill", isSelected: false)
                    tabItem(icon: "message.fill", isSelected: false)
                }
                .padding(.vertical, 28)
                .padding(.horizontal, 20)
                .background(Color(hex: "8E2426"))
            }
            .disabled(showMenu)
            .blur(radius: showMenu ? 3 : 0)
        
        }
        .animation(.easeInOut, value: showMenu)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // Helper function for coffee options
    private func coffeeOption(name: String, coffeeImage: String) -> some View {
        VStack {
            Image(coffeeImage)
                .resizable()
                .scaledToFit()
                .frame(width: 57, height: 99)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Text(name)
                .font(.custom("Baskerville", size: 16))
                .foregroundColor(Color(hex: "6F2232"))
                .multilineTextAlignment(.leading)
                .frame(width: 57 , height: 38)
                .padding(0)
                
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    // Helper function for tab items
    private func tabItem(icon: String, isSelected: Bool) -> some View {
        Button(action: {
            // Tab action
        }) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? .white : .white.opacity(0.7))
                .frame(maxWidth: .infinity)
        }
        .background(Color.clear)
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView(displayName: "Mark", username: "mszulc")
            DashboardView(displayName: nil, username: "unknown")
        }
    }
}


