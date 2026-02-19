# 🏫 Hall Management System (Omor ekushe hall)

A Web-First Responsive Hall Management System built using **Flutter**.

This project is designed to manage hall operations such as student seat applications, login management, and future role-based dashboards (Admin, Manager, Student).

The system follows modern UI architecture principles with a scalable and modular design. It uses **GoRouter** for navigation management and **GetX** for state management, ensuring clean routing structure, efficient state handling, and maintainable code architecture.


---

## 📌 Project Overview

The Hall Management System is being developed as a structured, production-ready Flutter application.

It focuses on:

- Web-first UI design
- Fully responsive layout (Mobile + Tablet + Desktop)
- Modular component-based structure
- Reusable UI components
- Clean architecture and folder organization

This project is part of a structured development journey toward building scalable management systems.

---

## 🚀 Implemented Features

### 🔹 Landing Page
- Government-style header
- Responsive hero section
- Gradient image overlay
- Login button
- Apply for Seat button

### 🔹 Reusable Animated Button Component
- Custom width & height
- Desktop base sizing
- Automatic responsive scaling
- Hover effect (Flutter Web)
- Tap animation
- Border & icon support

### 🔹 Modular Architecture
- Header separated into its own widget
- Hero section modularized
- About section modularized
- Clean separation of UI components

---

## 🧱 Project Structure
### follow MVC architecture 

```bash
lib/
│
├── controllers/
│
├── core/
│   ├── app_button/
│   │   └── login_page_animated_btn.dart
│   └── routes/
│       └── app_routes.dart
│
├── models/
│   └── role_model.dart
│
├── views/
│   ├── admin/
│   ├── manager/
│   ├── student/
│   └── login/
│       ├── role_based_login_page.dart
│       └── sections/
│           ├── header_section.dart
│           ├── hero_section.dart
│           └── about_section.dart
│
└── main.dart
```

---

## 📱 Responsive Strategy

The UI adapts dynamically using:

- `LayoutBuilder`
- `MediaQuery`
- Scale-based component sizing

### Breakpoints

| Device Type | Width Range |
|-------------|------------|
| Mobile | < 700px |
| Tablet | 700px – 1100px |
| Desktop | > 1100px |

---

## 🛠 Tech Stack


- Flutter
- Dart
- GoRouter (Navigation 2.0)
- GetX (State Management)


## 🎯 Current Development Status

✔ Landing Page UI Completed  
✔ Reusable Button System Implemented  
✔ Responsive Breakpoints Working  
✔ Modular Section-Based Structure  
✔ Clean Folder Architecture  

---

## 🚀 Development Log

---

### 📅 Day 1 – Project Initialization
- Created Flutter project
- Organized folder structure:
  - controllers/
  - core/
  - models/
  - views/
- Setup routing system (`app_routes.dart`)
- Created role model (`role_model.dart`)

---

### 📅 Day 2 – Reusable Button Component
- Built `AnimatedRoleButton`
- Added:
  - Custom width & height
  - Responsive scaling (Mobile / Tablet / Desktop)
  - Hover effect (Web)
  - Tap animation
  - Border support
- Refactored button to make it reusable

---

### 📅 Day 3 – Landing Page (Login Module)
- Designed `RoleBasedLoginPage`
- Created modular section structure:
  - `header_section.dart`
  - `hero_section.dart`
  - `about_section.dart`
- Implemented responsive breakpoints:
  - Mobile < 700px
  - Tablet 700–1100px
  - Desktop > 1100px
- Applied gradient overlay in hero section
- Implemented Web-first layout approach

---

### 📅 Day 4 – Architecture Improvement
- Separated large widgets into smaller components
- Improved clean UI hierarchy
- Reduced code complexity in main page
- Ensured modular scalability for future sections

---

## 📌 Current Status
✔ Landing Page UI Completed  
✔ Modular Section Architecture Implemented  
✔ Responsive Design Working  
✔ Reusable Button System Ready  

---

## ⏭ Next Planned Tasks
- Features Section
- Notice Bar
- Footer Section
- Role-based Login Navigation
- Admin Dashboard Layout
- Student Dashboard UI
- Manager Dashboard UI   aivabe add korbo 

## ▶ How to Run the Project

### Run on Web

```bash
flutter pub get
flutter run -d chrome
```

### Run on Android

```bash
flutter run
```

---

## 📈 Development Approach

This project follows:

- Web-first design strategy
- Clean architecture mindset
- Component reusability
- Scalable folder structure
- Continuous UI refinement

---

## 👨‍💻 Developer

**Mosharrof**  
CSE Student  
Flutter & System Architecture Learner  

---

## 🌟 Project Goal

To build a scalable, production-level Hall Management System using Flutter with a modern responsive architecture and clean modular structure.
