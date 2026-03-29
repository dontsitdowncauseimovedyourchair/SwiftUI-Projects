//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 20/03/26.
//

import SwiftUI

struct EditUserView : View {
    @Bindable var user : User
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate, displayedComponents: .date)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let user = User(name: "Pruebapro", city: "EDOMEX", joinDate: Date.now)
    EditUserView(user: user)
}
