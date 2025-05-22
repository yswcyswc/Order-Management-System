
# Roi du Pain – Online Bakery Ordering System

This repository contains the implementation of a comprehensive full-stack Order Management System for Roi du Pain, a fictional French bakery. The application is designed to streamline customer ordering, inventory tracking, shipping logistics, and administrative operations across multiple user roles.

Built using Ruby on Rails (v7.0.4) for the backend and integrated with a React-based frontend, this system leverages modern software design principles, emphasizing modularity, security, and maintainability.

🧩 Key Features
- MVC Architecture: Controllers and views follow Rails conventions and support clean, test-driven workflows. MaterializeCSS is used for layout and styling consistency.
- RESTful API: Fully-featured API layer with custom endpoints, fastjsonapi serialization, and structured JSON responses to power the React frontend.
- Secure Authentication & Role-Based Authorization: Implemented using Devise and CanCanCan, with strict access control based on user roles (customers, employees, managers).
- Cart Management & Order Processing: A reusable helper module (Cart) enables session-based cart functionality with automatic total calculations, validation, and shipping cost estimation.
- Data Modeling: A normalized PostgreSQL schema with constraints, associations, and scopes that reflect real-world bakery operations (items, prices, customers, orders, employees, addresses).
- Test-Driven Development: All features are backed by an extensive test suite using RSpec for unit/controller testing and Cucumber for full-stack behavioral testing. 100% test coverage is enforced.
- Front-End Views: Customer-facing pages are designed with user experience in mind, following design principles covered in class. Views are responsive, clean, and dynamic.
- Performance Optimization: ActiveRecord queries are optimized for eager loading and filtering to reduce database load and latency.

---

## 🧰 Tech Stack

- **Ruby** 3.1.4  
- **Rails** 7.0.4  
- **React** (frontend client)
- **PostgreSQL**  
- **RSpec**, **FactoryBot**, **Cucumber** (for TDD and BDD)  
- **MaterializeCSS** (optional UI styling)
- **fastjsonapi** (for high-performance JSON serialization)

---

## 📦 Core Features

### 🔁 Controllers

- Developed RESTful Rails controllers with support for full CRUD operations.
- Implemented custom API endpoints optimized with ActiveRecord queries and serialized using `fastjsonapi` for efficient data transfer to the React client.
- Integrated test-driven development using RSpec to ensure all controller logic meets spec requirements.
- Implemented authorization guards at both controller and view levels using CanCanCan.

### 🖼️ Views & Frontend Integration

- Views rendered using ERB templates and JSON APIs served to a React frontend client.
- Designed a responsive frontend experience using React components that consume Rails JSON APIs.
- Included secure session handling, role-based navigation, and conditional rendering based on user permissions.

### 🔐 Authentication & Authorization

- Built secure login and session workflows using Rails sessions and `has_secure_password`.
- Role-based access control enforced through CanCanCan with roles such as guest, customer, and manager.
- Protected both backend endpoints and frontend routes against unauthorized access.

---

## 🗃️ Models

The application is structured around a normalized relational database schema and ActiveRecord models. These encapsulate domain logic and business rules. Services are also written to handle shipping and prices logic.

### Key Models

- **Customer**  
  Represents a user with purchasing privileges.  
  Associations: `has_many :orders`, `has_one :user`

- **Item**  
  Represents a bakery product with pricing, availability, and category metadata.  
  Associations: `has_many :item_prices`, `has_many :order_items`

- **Order**  
  Represents a completed purchase made by a customer.  
  Includes status tracking, shipping cost calculation, and cart-to-order conversion logic.  
  Associations: `belongs_to :customer`, `has_many :order_items`

- **OrderItem**  
  Join model connecting `Orders` and `Items`.  
  Tracks quantity, unit price, and subtotal per item.

- **ItemPrice**  
  Supports historical and future pricing of bakery items.  
  Each `Item` can have multiple price records with active date ranges.

- **User**  
  Handles authentication and role management.  
  Associations: `has_one :customer`, `has_one :employee`

- **Employee**  
  Represents store staff with defined roles like `baker`, `shipper`, or `manager`.

---

## 🧪 Testing & Validation

- Built a robust testing suite using RSpec and FactoryBot.
- Covered model and controller specs with 100% test coverage.
- Verified end-to-end functionality using Cucumber scenarios.
- Test context set up using `rails db:contexts` to match expected system state.

```bash
bundle exec rspec       # Run unit tests
bundle exec cucumber    # Run integration tests
```

---

## 🚀 Setup

```bash
# Clone and install dependencies
git clone https://github.com/yourusername/roi-du-pain.git
cd roi-du-pain
bundle install
yarn install --check-files

# Set up database
rails db:drop db:create db:migrate db:seed
rails db:contexts

# Start server
rails server
```

---

## 📁 Project Structure

```
app/
├── controllers/
├── views/
├── models/
├── serializers/
├── helpers/
│   └── cart.rb
frontend/
├── components/
├── pages/
lib/
└── helpers/
spec/
features/
```

---

Developed as part of the RDP project for 67272 – Carnegie Mellon University, Spring 2025  
