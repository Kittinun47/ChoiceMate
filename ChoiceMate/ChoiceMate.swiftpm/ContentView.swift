import SwiftUI

//ProfileView
struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var username = "Kittinun Sukha"
    @State private var email = "Kittinun.sukha@example.com"
    @State private var totalDecisions = 156
    @State private var favoriteCategory = "Food"
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(Color(hex: "6600cc"))
                        
                        Text(username)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    
                    // Stats Cards
                    HStack(spacing: 15) {
                        StatCard(title: "Decisions", value: "\(totalDecisions)", icon: "chart.bar.fill")
                        StatCard(title: "Favorite", value: favoriteCategory, icon: "star.fill")
                    }
                    
                    // Recent Activity
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Activity")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ForEach(1...5, id: \.self) { _ in
                            ActivityRow()
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "6600cc"))
                }
            }
        }
    }
}

//Profile Components
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Color(hex: "6600cc"))
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

struct ActivityRow: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color(hex: "6600cc"))
                .frame(width: 8, height: 8)
            
            Text("Made a decision in")
                .foregroundColor(.gray)
            
            Text("Food")
                .fontWeight(.medium)
            
            Spacer()
            
            Text("2h ago")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 2)
    }
}

//SettingsView
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var notifications = true
    @State private var darkMode = false
    @State private var soundEffects = true
    @State private var language = "English"
    @State private var showDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    SettingsSection(title: "Preferences") {
                        SettingsToggleRow(title: "Notifications", isOn: $notifications)
                        SettingsToggleRow(title: "Dark Mode", isOn: $darkMode)
                        SettingsToggleRow(title: "Sound Effects", isOn: $soundEffects)
                        SettingsRow(title: "Language", value: language) {
                            // Language selection action
                        }
                    }
                    
                    SettingsSection(title: "Account") {
                        SettingsRow(title: "Edit Profile") {
                            // Edit profile action
                        }
                        SettingsRow(title: "Change Password") {
                            // Change password action
                        }
                        Button {
                            showDeleteAlert = true
                        } label: {
                            Text("Delete Account")
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                    }
                    
                    SettingsSection(title: "About") {
                        SettingsRow(title: "Privacy Policy") {
                            // Privacy policy action
                        }
                        SettingsRow(title: "Terms of Service") {
                            // Terms action
                        }
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "6600cc"))
                }
            }
        }
        .alert("Delete Account", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                // Handle account deletion
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
    }
}

//Settings Components
struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.leading)
                .padding(.bottom, 8)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.05), radius: 5)
        }
    }
}

struct SettingsRow: View {
    let title: String
    var value: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if let value = value {
                    Text(value)
                        .foregroundColor(.gray)
                }
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .foregroundColor(.primary)
    }
}

struct SettingsToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(title, isOn: $isOn)
            .padding()
    }
}

//ContentView Update
struct ContentView: View {
    @State private var selectedTab = 0
    @State private var navigationPath = NavigationPath()
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let modes = [
        TransportMode(name: "General", icon: "globe", color: Color(hex: "4B7BE5")),
        TransportMode(name: "Food", icon: "fork.knife", color: Color(hex: "10B981")),
        TransportMode(name: "Sport", icon: "figure.badminton", color: Color(hex: "F43F5E")),
        TransportMode(name: "Place", icon: "location.fill", color: Color(hex: "8B5CF6")),
        TransportMode(name: "Color", icon: "paintpalette.fill", color: Color(hex: "F59E0B")),
        TransportMode(name: "Custom", icon: "gearshape.fill", color: Color(hex: "6366F1"))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header with gradient background
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hello !")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Text("ChoiceMate")
                            .font(.system(size: 42))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Text("Start your new decision")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "6600cc"), Color(hex: "6699ff")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    
                    // Grid of modes
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 20) {
                            ForEach(modes) { mode in
                                NavigationLink(destination: RandomWordView(category: mode.name)) {
                                    ModeCard(mode: mode)
                                }
                            }
                        }
                        .padding(16)
                    }
                    
                    // Bottom navigation bar
                    HStack(spacing: 0) {
                        TabBarButton(icon: "house.fill", text: "Home", isSelected: selectedTab == 0)
                            .onTapGesture {
                                selectedTab = 0
                            }
                        
                        NavigationLink(destination: ProfileView()) {
                            TabBarButton(icon: "person.crop.circle", text: "Profile", isSelected: selectedTab == 1)
                        }
                        .onTapGesture {
                            selectedTab = 1
                        }
                        
                        NavigationLink(destination: SettingsView()) {
                            TabBarButton(icon: "gear", text: "Setting", isSelected: selectedTab == 2)
                        }
                        .onTapGesture {
                            selectedTab = 2
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .shadow(color: .black.opacity(0.05), radius: 10, y: -5)
                }
            }
        }
    }
}

struct TransportMode: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
}

struct ModeCard: View {
    let mode: TransportMode
    
    var body: some View {
        VStack {
            Image(systemName: mode.icon)
                .font(.system(size: 30))
                .foregroundColor(mode.color)
                .frame(width: 80, height: 80)
                .background(mode.color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text(mode.name)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

struct TabBarButton: View {
    let icon: String
    let text: String
    var isSelected: Bool = false
   
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(isSelected ? Color(hex: "8B5CF6") : .gray)
            
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(isSelected ? Color(hex: "8B5CF6") : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct RandomWordView: View {
    let category: String
    @State private var currentWord = ""
    @State private var isSpinning = false
    @State private var showingAddAlert = false
    @State private var newChoice = ""
    @State private var customWords: [String] = []
    @State private var showResult = false
    
    @State private var wordsByCategory: [String: [String]] = [
        "General": [
            // Basic Decision Options
            "Go for it",
            "Wait and see",
            "Not right now",
            "Absolutely yes",
            "Definitely no",
            
            // Timing-based
            "Do it today",
            "Try next week",
            "Perfect timing",
            "Need more time",
            "Act immediately",
            
            // Action-oriented
            "Take action",
            "Gather more info",
            "Ask for advice",
            "Trust your gut",
            "Sleep on it",
            
            // Risk Assessment
            "Worth the risk",
            "Play it safe",
            "Take the chance",
            "Be cautious",
            "Bold move needed",
            
            // Strategic Choices
            "Plan ahead",
            "Start small",
            "Go all in",
            "Test first",
            "Step by step",
            
            // Perspective-based
            "New approach",
            "Stay the course",
            "Change direction",
            "Keep it simple",
            "Think bigger",
            
            // Time-sensitive
            "Perfect moment",
            "Wait for better timing",
            "Strike while hot",
            "Pause and reflect",
            "Time to move",
            
            // Advice-style
            "Follow your heart",
            "Use logic",
            "Ask an expert",
            "Research more",
            "Trust yourself",
            
            // Outcome-focused
            "Great outcome likely",
            "Consider alternatives",
            "Promising results",
            "Better options exist",
            "Good potential"
        ],
        "Food": [
               // Cuisines
               "Italian", "Japanese", "Chinese", "Mexican", "Thai", "Indian", "French", "Korean",
               "Mediterranean", "Vietnamese", "American", "Greek", "Spanish", "Brazilian",
               
               // Specific Dishes
               "Pizza", "Sushi", "Burger", "Pasta", "Tacos", "Curry", "Salad", "Steak",
               "Sandwich", "Ramen", "BBQ", "Seafood", "Dim Sum", "Brunch",
               
               // Food Types
               "Vegetarian", "Vegan", "Gluten-free", "Fast food", "Fine dining", "Street food",
               "Buffet", "Home cooking", "Food truck", "Cafe", "Bakery"
           ],
           
           "Sport": [
               // Team Sports
               "Football", "Basketball", "Baseball", "Soccer", "Volleyball", "Hockey", "Rugby",
               
               // Individual Sports
               "Tennis", "Golf", "Swimming", "Running", "Cycling", "Boxing", "Yoga",
               "Martial Arts", "Rock Climbing", "Skiing", "Surfing", "Skateboarding",
               
               // Fitness Activities
               "Gym workout", "HIIT", "Pilates", "CrossFit", "Weight training", "Cardio",
               "Dance", "Stretching", "Walking", "Jogging", "Home workout"
           ],
           
           "Place": [
               // Nature
               "Beach", "Mountain", "Forest", "Lake", "Park", "Garden", "Island", "Waterfall",
               
               // Urban
               "City center", "Museum", "Art gallery", "Shopping mall", "Cafe", "Restaurant",
               "Movie theater", "Concert hall", "Library", "Bookstore",
               
               // Travel
               "Hotel", "Resort", "Camping", "Road trip", "Historical site", "Theme park",
               "National park", "Tourist spot", "Local market", "Hidden gem",
               
               // Activities
               "Indoor activity", "Outdoor adventure", "Cultural visit", "Relaxation spot",
               "Entertainment venue", "Educational place", "Scenic viewpoint"
           ],
           
           "Color": [
               // Basic Colors
               "Red", "Blue", "Green", "Yellow", "Purple", "Orange", "Pink", "Brown",
               "Black", "White", "Gray", "Gold", "Silver",
               
               // Shades
               "Navy blue", "Forest green", "Sky blue", "Mint green", "Hot pink", "Coral",
               "Turquoise", "Lavender", "Maroon", "Teal", "Violet", "Indigo",
               
               // Color Combinations
               "Blue & white", "Black & gold", "Red & black", "Purple & gold",
               "Green & brown", "Pink & gray", "Orange & blue", "Yellow & gray"
           ],
           
           "Mood": [
               // Activities
               "Read a book", "Watch a movie", "Listen to music", "Take a walk", "Meditate",
               "Call a friend", "Try something new", "Take a nap", "Exercise", "Draw or paint",
               
               // Entertainment
               "Comedy show", "Action movie", "Drama series", "Documentary", "Music playlist",
               "Podcast", "Video games", "Social media", "Photo album", "Creative project",
               
               // Relaxation
               "Bath time", "Massage", "Yoga session", "Deep breathing", "Garden visit",
               "Coffee break", "Tea time", "Nature sounds", "Mindfulness", "Stretching"
           ],
           
           "Custom": [
               // Default placeholder options that users can modify
               "Add more new choice"
           ]
       ]
    
    let spinDuration = 2.0
    let wordChangeDuration = 0.1
    
    var currentChoices: [String] {
        return wordsByCategory[category] ?? []
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Back button and title
            HStack {
                Text(category)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "6600cc"))
            }
            .padding(.top)
            
            if showResult {
                // Result View
                VStack(spacing: 12) {
                    Text("Your Choice")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Text(currentWord)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color(hex: "6600cc"))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 5)
                        )
                        .padding(.horizontal)
                    
                    Button(action: {
                        withAnimation {
                            showResult = false
                            currentWord = "Tap Spin!"
                        }
                    }) {
                        Text("Choose Again")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "6600cc"))
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                }
                .transition(.opacity)
                .animation(.easeInOut, value: showResult)
                
            } else {
                // List of choices in a ScrollView
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(currentChoices, id: \.self) { word in
                            HStack {
                                Text(word)
                                    .font(.system(size: 18))
                                    .padding(.leading)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Button(action: {
                                    deleteChoice(word)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.05), radius: 2)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity)
                
                // Spinning result display
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 5)
                        .frame(height: 100)
                    
                    Text(currentWord)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(hex: "6600cc"))
                        .opacity(isSpinning ? 0.7 : 1.0)
                        .scaleEffect(isSpinning ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isSpinning)
                }
                .padding(.horizontal)
                
                // Action buttons
                VStack(spacing: 12) {
                    Button(action: { showingAddAlert = true }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Choice")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "6600cc"))
                        .cornerRadius(15)
                    }
                    
                    Button(action: startSpinning) {
                        Text("Spin!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "6600cc"), Color(hex: "6699ff")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                    }
                    .disabled(isSpinning || currentChoices.isEmpty)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .alert("Add New Choice", isPresented: $showingAddAlert) {
            TextField("Enter your choice", text: $newChoice)
            Button("Cancel", role: .cancel) {
                newChoice = ""
            }
            Button("Add") {
                addChoice(newChoice)
                newChoice = ""
            }
        } message: {
            Text("Enter a new choice to add to the list")
        }
        .onAppear {
            currentWord = "Tap Spin!"
        }
    }
    
    func startSpinning() {
        isSpinning = true
        let words = currentChoices
        
        for i in 0..<20 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * wordChangeDuration) {
                currentWord = words.randomElement() ?? ""
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + spinDuration) {
            currentWord = words.randomElement() ?? ""
            isSpinning = false
            withAnimation {
                showResult = true
            }
        }
    }
    
    func addChoice(_ choice: String) {
        guard !choice.isEmpty else { return }
        wordsByCategory[category]?.append(choice)
    }
    
    func deleteChoice(_ choice: String) {
        wordsByCategory[category]?.removeAll { $0 == choice }
    }
}
















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
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
