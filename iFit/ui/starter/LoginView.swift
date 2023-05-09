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
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var showingAlert = false
    @State private var isRegistering = false
    @State private var isLogged: Bool? = false
    
    var body: some View {
        VStack {
            Image("Logo")
            HStack {
                Text("Username:")
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            HStack {
                Text("Password:")
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            
            Button(action: {
                login()
            }) {
                Text("Login")
            }
            .padding()
            .foregroundColor(.brown)
            .fontWeight(.bold)
            
            Spacer()
            NavigationLink(destination: RegisterView()) {
                            Text("Don't have an account? Register here.")
                                .foregroundColor(.blue)
                                .fontWeight(.light)
                                .font(.footnote)
            }
            NavigationLink(
                destination: TabBarView(localUsername: username).navigationBarBackButtonHidden(true),
                tag: true, selection: $isLogged
                    ) {
                        EmptyView()
                    }
                    .navigationBarBackButtonHidden(true)
                    .onDisappear {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("登录错误"), message: Text("用户名或密码错误，请重试"), dismissButton: .default(Text("确定")))
        }
        
    }
    
    
    private func login() {
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "username == %@ && password == %@", username, password)
        
        do {
            let users = try viewContext.fetch(request)
            if let user = users.first {
                // Successfully logged in.
                // Do something here...
                self.username = user.username ?? "null"
                $isLogged.wrappedValue = true
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
