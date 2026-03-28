//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Alejandro González on 09/01/26.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItemSD.self)
    }
}
