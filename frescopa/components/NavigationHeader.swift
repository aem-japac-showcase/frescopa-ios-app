import SwiftUI

struct NavigationHeader: View {
    var username: String
    var onLogout: (() -> Void)?
    
    var body: some View {
        HStack {
            Image("hamburger")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color(hex: "6F2232"))
                .frame(width: 33, height: 27)
            
            Spacer()
            
            HStack(spacing: 10) {
                Image("FrescopaLogotype")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 185, height: 51)
            }
            
            Spacer()
            
            Image(username)
                .resizable()
                .frame(width: 35, height: 35)
                .onTapGesture {
                    onLogout?()
                }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 12)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.3), radius: 1)
    }
}

struct NavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeader(username: "mszulc", onLogout: nil)
            .previewLayout(.sizeThatFits)
    }
}
