//
//  RegisterView.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/6.
//

import SwiftUI
import CoreData
import Foundation

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var isActive: Bool = false
    @State private var isSuccessed: Bool = false
    @State private var isFailed: Bool = false
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                register()
            }) {
                Text("Register")
            }
            .padding()
            Spacer()
            Text("Already have an account? Login here.")
                .foregroundColor(.blue)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .fontWeight(.light)
                .font(.footnote)
        }.padding()
            .alert(isPresented: $isSuccessed) {
                Alert(title: Text("注册成功"), message: Text("您已经注册成功！请返回登陆。"), dismissButton: .default(Text("确定"), action: {self.presentationMode.wrappedValue.dismiss()}
                                                                                                   )
                )
            }
        
    }
    
    private func register() {
        // Create a new user object using the entered data.
        let newUser = User(context: viewContext)
        newUser.username = username
        newUser.password = password
        newUser.phoneNumber = phoneNumber
        newUser.email = email
        
        // Save the new user to Core Data.
        do {
            let request = NSFetchRequest<User>(entityName: "User")
            request.predicate = NSPredicate(format: "username == %@ ", newUser.username!)
            do {
                let users = try viewContext.fetch(request)
                if !users.isEmpty {
                    self.isFailed = true
                }
            } catch {
                // Error fetching users.
                // Show an error message to the user.
            }
            try viewContext.save()
            self.isSuccessed = true
            // Successfully registered.
            // Do something here...
            
        } catch {
            // Error saving user.
            // Show an error message to the user.
        }
    }
}

