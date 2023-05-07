//
//  LoginView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/5.
//
import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.isLogged) private var isLogged
    @Environment(\.localUser) private var localUser
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var user: User = User()
    
    @State private var showingAlert = false
    @State private var isRegistering = false
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                login()
            }) {
                Text("Login")
            }
            .padding()
            .environment(\.localUser, $user)
            Spacer()
            NavigationLink(destination: RegisterView()) {
                            Text("Don't have an account? Register here.")
                                .foregroundColor(.blue)
            }
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("登录错误"), message: Text("用户名或密码错误，请重试"), dismissButton: .default(Text("确定")))
        }
    }
    
    
    private func login() {
        // Check if user has valid credentials.
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "username == %@ && password == %@", username, password)
        
        do {
            let users = try viewContext.fetch(request)
            if let user = users.first {
                // Successfully logged in.
                // Do something here...
//                self.user = user
                localUser.wrappedValue = user
                print(localUser.wrappedValue)
                isLogged.wrappedValue = true
                print(isLogged.wrappedValue)
            } else {
                // Invalid credentials.
                // Show an error message to the user.
                self.showingAlert = true
            }
        } catch {
            // Error fetching users.
            // Show an error message to the user.
        }
    }
}
