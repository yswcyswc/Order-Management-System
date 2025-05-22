
# Roi du Pain – Online Bakery Ordering System

This repository implements the controller and view layers for **Roi du Pain**, a full-stack online bakery ordering platform developed using Ruby on Rails and React. The system supports customer interactions, order tracking, inventory management, and shopping cart functionality. 

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
